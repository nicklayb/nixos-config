{ pkgs, mainUser, stateVersion, ... }: {
  programs.home-manager.enable = true;
  home.stateVersion = stateVersion;
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

  programs.alacritty.enable = true;

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

  # Hyprland
  xdg.configFile."hypr/hyprland.conf".source = ./configs/hypr/hyprland.conf;
  xdg.configFile."hypr/hypridle.conf".source = ./configs/hypr/hypridle.conf;
  xdg.configFile."hypr/hyprlock.conf".source = ./configs/hypr/hyprlock.conf;
  xdg.configFile."hypr/hyprpaper.conf".source = ./configs/hypr/hyprpaper.conf;
  xdg.configFile."hypr/latte.conf".source = ./configs/hypr/latte.conf;

  # Waybar
  xdg.configFile."waybar/config".source = ./configs/waybar/config;
  xdg.configFile."waybar/mocha.css".source = ./configs/waybar/mocha.css;
  xdg.configFile."waybar/nixos.svg".source = ./configs/waybar/nixos.svg;
  xdg.configFile."waybar/style.css".source = ./configs/waybar/style.css;

  # Wofi
  xdg.configFile."wofi/config".source = ./configs/wofi/config;
  xdg.configFile."wofi/style.css".source = ./configs/wofi/style.css;

  # Alacritty
  xdg.configFile."alacritty/alacritty.toml".source = ./configs/alacritty/alacritty.toml;
}
