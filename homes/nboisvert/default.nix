{ pkgs, mainUser, ... }: {
  programs.home-manager.enable = true;
  home.username = mainUser.username;
  home.homeDirectory = "/home/${mainUser.username}";

  home.packages = [
    pkgs.slack
    pkgs.elixir
    pkgs.gnome.nautilus
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
  };

  programs.alacritty = {
    enable = true;
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

  xdg.configFile."hypr/hyprland.conf".source = ./configs/hypr/hyprland.conf;
  xdg.configFile."hypr/hypridle.conf".source = ./configs/hypr/hypridle.conf;
  xdg.configFile."hypr/hyprlock.conf".source = ./configs/hypr/hyprlock.conf;
  xdg.configFile."hypr/hyprpaper.conf".source = ./configs/hypr/hyprpaper.conf;
}
