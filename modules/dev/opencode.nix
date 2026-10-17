{
  config,
  lib,
  unstable-pkgs,
  username,
  ...
}:
let
  cfg = config.mods.opencode;

  opencodeConfig = {
    "$schema" = "https://opencode.ai/config.json";

    model = "ollama/${cfg.ollama.model}";

    agent.build.prompt = ''
      Tool usage instructions:
      - Never call a subagent name such as "explore" or "general"
        as if it were a tool.
      - To delegate a task, use the "task" tool.
      - When using the "task" tool, specify the subagent type
        and provide its prompt and description.
      - For simple repository exploration, you may directly use
        glob, grep, list, read, and bash.
      - Never output pseudo-XML or textual representations of
        tool calls. Invoke the available tools directly.
    '';

    provider.ollama = {
      npm = "@ai-sdk/openai-compatible";
      name = "Ollama - Mac Mini";

      options.baseURL = "${cfg.ollama.baseURL}/v1";

      models.${cfg.ollama.model} = {
        name = cfg.ollama.model;
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
    environment.systemPackages = [ unstable-pkgs.opencode ];

    # home-manager.users.${username} = {
    #   xdg.configFile."opencode/opencode.json".text = builtins.toJSON opencodeConfig;
    # };
  };

}
