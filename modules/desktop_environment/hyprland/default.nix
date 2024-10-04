{ config, lib, pkgs, mainUser, ... }: {
  options = {
    mods.hyprland = {
      enable = lib.mkEnableOption "Enables Hyprland";
      monitor = lib.mkOption {
        description = "Hyprland monitor configuration";
        type = lib.types.listOf lib.types.str;
        default = [];
      };
      wallpapers = lib.mkOption {
        description = "Hyprpaper wallpapers";
        type = lib.types.listOf lib.types.str;
        default = [];
      };
      wallpaperPreloads = lib.mkOption {
        description = "Hyprpaper preloads";
        type = lib.types.listOf lib.types.str;
        default = ["/home/${mainUser.username}/.background"];
      };
    };
  };
  config = lib.mkIf config.mods.hyprland.enable {
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.theme = "sugar-candy";
    services.displayManager.sddm.wayland.enable = true;
    programs.hyprland.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    };

    environment.systemPackages = [
      pkgs.hyprpaper
      pkgs.hyprlock
      pkgs.hypridle
      (pkgs.callPackage ./sugar_candy.nix { }).sddm-sugar-candy-theme
      pkgs.libsForQt5.qt5.qtgraphicaleffects
    ];

    home-manager.users.${mainUser.username} = {
      xdg.configFile."hypr/latte.conf".source = ./latte.conf;

      wayland.windowManager.hyprland = {
        enable = true;
        settings = import ./hyprland.nix { config = config; monitor = config.mods.hyprland.monitor; };
      };
      services.hyprpaper = {
        enable = true;
        settings = import ./hyprpaper.nix { 
          preloads = config.mods.hyprland.wallpaperPreloads; 
          wallpapers = config.mods.hyprland.wallpapers;
        };
      };
      services.hypridle = {
        enable = true;
        settings = import ./hypridle.nix { };
      };
      programs.hyprlock = {
        enable = true;
        settings = import ./hyprlock.nix { };
      };
    };
  };
}
