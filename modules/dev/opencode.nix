{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.mods.opencode;

  opencodeConfig = {
    "$schema" = "https://opencode.ai/config.json";

    model = "ollama/${cfg.model}";

    provider.ollama = {
      npm = "@ai-sdk/openai-compatible";
      name = "Ollama - Mac Mini";

      options.baseURL = "${cfg.baseURL}/v1";

      models.${cfg.model} = {
        name = cfg.model;
        limit = {
          context = 65536;
          output = 8192;
        };
      };
    };

  };
in
{
  options = {
    mods.opencode = {
      enable = lib.mkEnableOption "Enables OpenCode";
      ollama = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "Ollama - Local";
          description = "Ollama instance name";
        };
        baseURL = lib.mkOption {
          type = lib.types.str;
          default = "http://studio.nboisvert.local:11434";
          description = "Ollama server";
        };

        model = lib.mkOption {
          type = lib.types.str;
          default = "qwen3-coder:30b";
          description = "Ollama model";
        };
      };
    };
  };
  config = lib.mkIf config.mods.opencode.enable {
    environment.systemPackages = [ pkgs.opencode ];

    home-manager.users.${username} = {
      xdg.configFile."opencode/opencode.json".text = builtins.toJSON opencodeConfig;
    };
  };

}
