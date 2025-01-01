{ pkgs, mainUser, stateVersion, inputs, ... }: {
  programs.home-manager.enable = true;
  home.stateVersion = stateVersion;
  home.username = mainUser.username;
  home.homeDirectory = "/home/${mainUser.username}";

  home.packages = [
    pkgs.slack
    pkgs.elixir
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_INSECURE = "1";
    NIXOS_OZONE_WL = "1";
    SDL_VIDEODRIVER = "wayland";
  };

  programs.git = {
    enable = true;
    userName = mainUser.username;
    userEmail = mainUser.email;
    diff-so-fancy.enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "fzf" "web-search" ];
      theme = "eastwood";
    };
  };

  nixpkgs.config.allowUnfree = true;

  # Scripts
  xdg.configFile."scripts/power-menu.sh".source = ./scripts/power-menu.sh;
  xdg.configFile."scripts/wikis.sh".source = ./scripts/wikis.sh;

  xdg.configFile."nvim".source = inputs.astronvim-config;
}
