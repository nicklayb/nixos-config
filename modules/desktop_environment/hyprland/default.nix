{ config, system, lib, pkgs, inputs, username, ... }: {
  options = {
    mods.hyprland = {
      enable = lib.mkEnableOption "Enables Hyprland";
      monitor = lib.mkOption {
        description = "Hyprland monitor configuration";
        type = lib.types.listOf lib.types.str;
        default = [ ];
      };
      hyprlock = {
        battery = lib.mkEnableOption "Enables Battery display in hyprlock";
      };
      wallpapers = lib.mkOption {
        description = "Hyprpaper wallpapers";
        type = lib.types.listOf lib.types.str;
        default = [ ];
      };
      wallpaperPreloads = lib.mkOption {
        description = "Hyprpaper preloads";
        type = lib.types.listOf lib.types.str;
        default = [ "/home/${username}/.background" ];
      };
      extraBindings = lib.mkOption {
        description = "Extra bindings to register";
        type = lib.types.listOf lib.types.str;
        default = [ ];
      };
      extraBindingsL = lib.mkOption {
        description = "Extra bindings (bindl) to register";
        type = lib.types.listOf lib.types.str;
        default = [ ];
      };
      gtkTheme = {
        package = lib.mkOption {
          description = "GTK theme package";
          type = lib.types.package;
          default = pkgs.tokyonight-gtk-theme;
        };
        name = lib.mkOption {
          description = "GTK theme name";
          type = lib.types.str;
          default = "Tokyonight-Dark";
        };
      };
      hypridle = {
        timers = {
          sleep = lib.mkOption {
            description = "Sleep timer";
            type = lib.types.str;
            default = "1800";
          };
          lock = lib.mkOption {
            description = "Lock timer";
            type = lib.types.str;
            default = "300";
          };
        };
      };
      gaps = lib.mkOption {
        description = "Gaps between windows, both in and out";
        type = lib.types.int;
        default = 5;
      };
      dimInactive = lib.mkOption {
        description = "Dim inactive windows";
        type = lib.types.bool;
        default = true;
      };
      sddmSettings = lib.mkOption {
        description = "Settings for SDDM";
        type = lib.types.attrs;
        default = {};
      };
    };
  };
  config = lib.mkIf config.mods.hyprland.enable {
    services.xserver.enable = true;
    services.displayManager.sddm = {
      enable = true;
      theme = "sugar-candy";
      wayland.enable = true;
      settings = config.mods.hyprland.sddmSettings;
    };
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    };

    environment.systemPackages = [
      pkgs.hyprpaper
      pkgs.hyprlock
      pkgs.hypridle
      pkgs.hyprshot
      pkgs.acpi
      pkgs.libnotify
      (pkgs.callPackage ./sugar_candy.nix { }).sddm-sugar-candy-theme
      pkgs.libsForQt5.qt5.qtgraphicaleffects
      pkgs.lxqt.lxqt-policykit
      inputs.palet.packages.${system}.default
    ];

    security.polkit.enable = true;

    home-manager.users.${username} = {
    xdg.configFile = {
      "gtk-4.0/assets".source = "${config.mods.hyprland.gtkTheme.package}/share/themes/${config.mods.hyprland.gtkTheme.name}/gtk-4.0/assets";
      "gtk-4.0/gtk.css".source = "${config.mods.hyprland.gtkTheme.package}/share/themes/${config.mods.hyprland.gtkTheme.name}/gtk-4.0/gtk.css";
      "gtk-4.0/gtk-dark.css".source = "${config.mods.hyprland.gtkTheme.package}/share/themes/${config.mods.hyprland.gtkTheme.name}/gtk-4.0/gtk-dark.css";
    };

      services.dunst.enable = true;

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
        settings = import ./hypridle.nix { timers = config.mods.hyprland.hypridle.timers; };
      };
      programs.hyprlock = {
        enable = true;
        settings = import ./hyprlock.nix { battery = config.mods.hyprland.hyprlock.battery; };
      };
    };
  };
}
