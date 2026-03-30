use std::{collections::HashMap, fs, path::Path, sync::Arc, time::Duration};

use axum::{
    extract::State,
    routing::post,
    Json, Router,
};
use serde::{Deserialize, Serialize};
use rusqlite::{params, Connection};
use tokio::sync::RwLock;
use tokio::task;
use notify::{Watcher, RecommendedWatcher, RecursiveMode, EventKind};
use tesseract::Tesseract;
use uuid::Uuid;
use bincode;

// ---------------------------
// Structures de données
// ---------------------------

#[derive(Clone)]
struct AppState {
    db: Arc<RwLock<Connection>>,
    vector_cache: Arc<RwLock<HashMap<String, Vec<f32>>>>,
    data_dir: String,
}

#[derive(Deserialize)]
struct Query {
    question: String,
}

#[derive(Serialize)]
struct Response {
    answer: String,
}

// ---------------------------
// Utilitaires
// ---------------------------

fn init_db(path: &str) -> Connection {
    let conn = Connection::open(path).expect("Failed to open DB");
    conn.execute_batch(
        "
        CREATE TABLE IF NOT EXISTS documents (
            id TEXT PRIMARY KEY,
            path TEXT NOT NULL,
            embedding BLOB NOT NULL
        );
    ",
    ).unwrap();
    conn
}

// Simple placeholder embedding: ASCII sum / 256 as f32 vector
fn embed_text(text: &str) -> Vec<f32> {
    vec![text.bytes().map(|b| b as f32).sum::<f32>() / 256.0]
}

// Compute cosine similarity
fn cosine_sim(a: &[f32], b: &[f32]) -> f32 {
    let dot: f32 = a.iter().zip(b.iter()).map(|(x, y)| x * y).sum();
    let norm_a: f32 = a.iter().map(|x| x*x).sum::<f32>().sqrt();
    let norm_b: f32 = b.iter().map(|x| x*y).sum::<f32>().sqrt();
    dot / (norm_a * norm_b + 1e-8)
}

// ---------------------------
// Ingestion OCR
// ---------------------------

fn process_file(path: &Path) -> (String, Vec<f32>) {
    let mut tess = Tesseract::new(None, Some("eng")).unwrap();
    tess.set_image(path).unwrap();
    let text = tess.get_text().unwrap_or_default();
    let embedding = embed_text(&text);
    (text, embedding)
}

async fn ingest_file(state: Arc<AppState>, path: String) {
    let path_clone = path.clone();
    let (text, embedding) = task::spawn_blocking(move || process_file(Path::new(&path_clone)))
        .await
        .unwrap();

    let id = Uuid::new_v4().to_string();
    let embedding_bytes = bincode::serialize(&embedding).unwrap();

    let mut db = state.db.write().await;
    db.execute(
        "INSERT INTO documents (id, path, embedding) VALUES (?1, ?2, ?3)",
        params![id, path, embedding_bytes],
    )
    .unwrap();

    state.vector_cache.write().await.insert(id.clone(), embedding);

    // Move processed file
    let processed_dir = format!("{}/processed", state.data_dir);
    fs::create_dir_all(&processed_dir).unwrap();
    let filename = Path::new(&path).file_name().unwrap();
    fs::rename(&path, Path::new(&processed_dir).join(filename)).unwrap();

    println!("Processed file: {}", path);
}

// ---------------------------
// Watcher
// ---------------------------

async fn watch_inbox(state: Arc<AppState>) -> notify::Result<()> {
    let inbox_dir = format!("{}/inbox", state.data_dir);
    fs::create_dir_all(&inbox_dir).unwrap();

    let mut watcher: RecommendedWatcher = RecommendedWatcher::new(
        move |res| {
            if let Ok(event) = res {
                if let EventKind::Create(_) = event.kind {
                    for path in event.paths {
                        let state_clone = state.clone();
                        tokio::spawn(async move {
                            ingest_file(state_clone, path.to_string_lossy().to_string()).await;
                        });
                    }
                }
            }
        },
        notify::Config::default(),
    )?;

    watcher.watch(Path::new(&inbox_dir), RecursiveMode::NonRecursive)?;
    println!("Watching inbox: {}", inbox_dir);

    loop { tokio::time::sleep(Duration::from_secs(60)).await; }
}

// ---------------------------
// Query API
// ---------------------------

#[axum::debug_handler]
async fn query(
    State(state): State<Arc<AppState>>,
    Json(payload): Json<Query>,
) -> Json<Response> {
    let q_embed = embed_text(&payload.question);

    let db = state.db.read().await;
    let mut best_score = f32::MIN;
    let mut best_path = String::new();

    let mut stmt = db.prepare("SELECT id, path, embedding FROM documents").unwrap();
    let rows = stmt.query_map([], |row| {
        let id: String = row.get(0)?;
        let path: String = row.get(1)?;
        let emb_bytes: Vec<u8> = row.get(2)?;
        let emb: Vec<f32> = bincode::deserialize(&emb_bytes).unwrap();
        Ok((id, path, emb))
    }).unwrap();

    for row in rows {
        let (_id, path, emb) = row.unwrap();
        let sim = cosine_sim(&q_embed, &emb);
        if sim > best_score {
            best_score = sim;
            best_path = path;
        }
    }

    Json(Response {
        answer: format!("Closest document: {}", best_path),
    })
}

// ---------------------------
// Main
// ---------------------------

#[tokio::main]
async fn main() {
    let data_dir = std::env::var("DATA_DIR").unwrap_or_else(|_| "./data".to_string());
    let db_path = format!("{}/vector.db", data_dir);
    let conn = init_db(&db_path);

    let state = Arc::new(AppState {
        db: Arc::new(RwLock::new(conn)),
        vector_cache: Arc::new(RwLock::new(HashMap::new())),
        data_dir: data_dir.clone(),
    });

    // spawn watcher
    let state_clone = state.clone();
    tokio::spawn(async move {
        watch_inbox(state_clone).await.unwrap();
    });

    let app = Router::new()
        .route("/query", post(query))
        .with_state(state);

    let port: u16 = std::env::var("PORT").unwrap_or_else(|_| "3000".to_string()).parse().unwrap();
    println!("Server listening on 0.0.0.0:{}", port);

    axum::Server::bind(&([0, 0, 0, 0], port).into())
        .serve(app.into_make_service())
        .await
        .unwrap();
}
