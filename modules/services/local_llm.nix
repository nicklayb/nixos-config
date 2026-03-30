{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.mods.local_llm;
  isDarwin = pkgs.stdenv.isDarwin;

  ragPkg = pkgs.rustPlatform.buildRustPackage {
    pname = "local-llm-rag";
    version = "0.1.0";
    src = ./local_llm/rag;
    cargoLock.lockFile = ./local_llm/rag/Cargo.lock;
  };
in
{
  options.mods.local_llm = {
    enable = lib.mkEnableOption "Local AI stack";

    dataDir = lib.mkOption {
      type = lib.types.str;
      default = "/data/docs";
    };

    port = lib.mkOption {
      type = lib.types.int;
      default = 3000;
    };

    ollama.host = lib.mkOption {
      type = lib.types.str;
      default = "127.0.0.1";
    };

    ollama.port = lib.mkOption {
      type = lib.types.int;
      default = 11434;
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [
      pkgs.ollama
      pkgs.tesseract
      ragPkg
    ];

    system.activationScripts.localAiDirs.text = ''
      mkdir -p ${cfg.dataDir}/inbox
      mkdir -p ${cfg.dataDir}/processed
    '';

    #################################
    # Ollama
    #################################

    launchd.daemons.ollama = lib.mkIf isDarwin {
      serviceConfig = {
        ProgramArguments = [
          "${pkgs.ollama}/bin/ollama"
          "serve"
        ];
        EnvironmentVariables = {
          OLLAMA_HOST = "${cfg.ollama.host}:${toString cfg.ollama.port}";
        };
        RunAtLoad = true;
        KeepAlive = true;
      };
    };

    #################################
    # RAG service
    #################################

    launchd.daemons.rag = lib.mkIf isDarwin {
      serviceConfig = {
        ProgramArguments = [ "${ragPkg}/bin/local-llm-rag" ];
        EnvironmentVariables = {
          DATA_DIR = cfg.dataDir;
          PORT = toString cfg.port;
          OLLAMA_URL = "http://${cfg.ollama.host}:${toString cfg.ollama.port}";
        };
        RunAtLoad = true;
        KeepAlive = true;
      };
    };
  };
}
