{
  config,
  lib,
  username,
  ...
}:
{
  options = {
    mods.zsh = {
      enable = lib.mkOption {
        description = "Enables Zsh (default shell)";
        type = lib.types.bool;
        default = true;
      };
      theme = lib.mkOption {
        type = lib.types.str;
        default = "sunaku";
        description = "The Zsh theme to use.";
      };
      extraContent = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Extra content to add to the Zsh configuration.";
      };
    };
  };

  config = lib.mkIf config.mods.zsh.enable {
    home-manager.users.${username}.programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "fzf"
          "web-search"
        ];
        theme = config.mods.zsh.theme;
      };
      initContent = ''
        source ~/.zsh/init || true
      ''
      + config.mods.zsh.extraContent;
    };
  };
}
