{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.mods.local_llm;

  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    optionalString
    ;

  modelsScript = pkgs.writeShellScript "local-ai-pull-models" ''
    set -euo pipefail

    export PATH="${
      lib.makeBinPath [
        pkgs.coreutils
        pkgs.curl
        pkgs.ollama
      ]
    }:$PATH"

    echo "Waiting for Ollama..."

    until curl \
      --fail \
      --silent \
      --show-error \
      http://127.0.0.1:${toString cfg.ollama.port}/api/tags \
      > /dev/null
    do
      sleep 2
    done

    ${lib.concatMapStringsSep "\n" (model: ''
      echo "Pulling model: ${model}"
      ollama pull ${lib.escapeShellArg model}
    '') cfg.models}
  '';

in
{
  options.mods.local_llm = {
    enable = mkEnableOption "local Ollama and Open WebUI services";

    models = mkOption {
      type = types.listOf types.str;
      default = [
        "qwen3:8b"
        "nomic-embed-text"
      ];

      description = ''
        Ollama models to download automatically.

        The embedding model is useful for document search and RAG.
      '';
    };

    dataDirectory = mkOption {
      type = types.str;
      default = "${config.system.primaryUserHome}/Library/Application Support/local-ai";

      description = ''
        Directory used for Ollama models and Open WebUI data.
      '';
    };

    ollama = {
      port = mkOption {
        type = types.port;
        default = 11434;
      };

      host = mkOption {
        type = types.str;
        default = "127.0.0.1";

        description = ''
          Address used by Ollama.

          Keeping this on 127.0.0.1 prevents Ollama from being
          exposed directly to the local network.
        '';
      };
    };

    openWebUI = {
      port = mkOption {
        type = types.port;
        default = 3000;
      };

      image = mkOption {
        type = types.str;
        default = "ghcr.io/open-webui/open-webui:main";

        description = ''
          Docker image used for Open WebUI.

          For long-term reproducibility, replace the rolling `main`
          tag with a specific version or image digest.
        '';
      };

      name = mkOption {
        type = types.str;
        default = "Local AI";
      };

      extraEnvironment = mkOption {
        type = types.attrsOf types.str;
        default = { };
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.ollama
      pkgs.docker-client
    ];

    launchd.daemons.local-ai-ollama = {
      serviceConfig = {
        ProgramArguments = [
          "${pkgs.ollama}/bin/ollama"
          "serve"
        ];

        EnvironmentVariables = {
          OLLAMA_HOST = "${cfg.ollama.host}:${toString cfg.ollama.port}";

          OLLAMA_MODELS = "${cfg.dataDirectory}/ollama";

          HOME = config.system.primaryUserHome;
        };

        RunAtLoad = true;
        KeepAlive = true;

        StandardOutPath = "/var/log/local-ai-ollama.log";

        StandardErrorPath = "/var/log/local-ai-ollama-error.log";
      };
    };

    launchd.user.agents.local-ai-open-webui = {
      serviceConfig = {
        ProgramArguments = [
          "/usr/bin/env"
          "docker"
          "run"
          "--rm"
          "--name"
          "local-ai-open-webui"
          "--publish"
          "${toString cfg.openWebUI.port}:8080"
          "--add-host"
          "host.docker.internal:host-gateway"
          "--volume"
          "${cfg.dataDirectory}/open-webui:/app/backend/data"
          "--env"
          "OLLAMA_BASE_URL=http://host.docker.internal:${toString cfg.ollama.port}"
          "--env"
          "WEBUI_NAME=${cfg.openWebUI.name}"
        ]
        ++ lib.concatLists (
          lib.mapAttrsToList (name: value: [
            "--env"
            "${name}=${value}"
          ]) cfg.openWebUI.extraEnvironment
        )
        ++ [
          cfg.openWebUI.image
        ];

        RunAtLoad = true;
        KeepAlive = true;

        StandardOutPath = "/tmp/local-ai-open-webui.log";

        StandardErrorPath = "/tmp/local-ai-open-webui-error.log";
      };
    };

    launchd.user.agents.local-ai-pull-models = {
      serviceConfig = {
        ProgramArguments = [
          "${modelsScript}"
        ];

        RunAtLoad = true;

        KeepAlive = false;

        ProcessType = "Background";

        StandardOutPath = "/tmp/local-ai-models.log";

        StandardErrorPath = "/tmp/local-ai-models-error.log";
      };
    };

    system.activationScripts.local-ai.text = ''
      mkdir -p \
        "${cfg.dataDirectory}/ollama" \
        "${cfg.dataDirectory}/open-webui"

      chown -R \
        "${config.system.primaryUser}" \
        "${cfg.dataDirectory}"
    '';
  };
}
