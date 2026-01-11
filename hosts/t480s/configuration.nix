{
  lib,
  pkgs,
  stateVersion,
  username,
  hostname,
  mainUser,
  system,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  environment.systemPackages = [
    pkgs.obs-studio
    pkgs.brightnessctl
    (pkgs.nnn.override { withNerdIcons = true; })
    inputs.plexm3u.packages.${system}.default
  ];

  home-manager.users.${username} = {
    xdg.configFile = {
      "hypr/scripts/lidclosed".source = ./scripts/lidclosed.sh;
    };
  };

  systemd.user.services.lid_switch = {
    enable = true;
    unitConfig = {
      type = "oneshot";
    };
    description = "Lid switch handler";
    after = [ "graphical-session.target" ];
    serviceConfig = {
      execStart =
        let
          script = pkgs.writeShellApplication {
            name = "lidclosed";
            text = ./scripts/lidclosed.sh;
          };
        in
        lib.getExe script;
    };
  };

  mods = {
    _1password.enable = true;
    alacritty = {
      enable = true;
      fontSize = 10;
    };
    bluetooth.enable = true;
    dbeaver.enable = true;
    deluge.enable = true;
    docker.enable = true;
    firefox.enable = true;
    github.enable = true;
    hyprland = {
      enable = true;
      hyprlock = {
        battery = true;
      };
      monitor = [
        "eDP-1,1920x1080@60.00Hz,0x1440,1"
        "HDMI-A-2,2560x1440@120.00Hz,0x0,1"
        "DP-1,3440x1440@120.00Hz,0x0,1"
        "DP-3,3440x1440@120.00Hz,0x0,1"
        "DP-4,3440x1440@120.00Hz,0x0,1"
      ];
      hyprpaper = {
        randomWallpapers = {
          enable = true;
          query = "mountains";
          mapping = {
            "/home/${username}/.background" = [ "eDP-1" ];
            "/home/${username}/.background-external" = [
              "HDMI-A-2"
              "DP-1"
              "DP-3"
              "DP-4"
            ];
          };
        };
      };
      extraBindingsL = [
        ", switch:on:Lid Switch, exec, ~/.config/hypr/scripts/lidclosed"
        ", switch:off:Lid Switch, exec, hyprctl keyword monitor \"e-DP-1, enable\" & hyprctl reload"
      ];
      extraBindings = [
        "$mainMod SHIFT, M, exec, ~/.config/scripts/monitors.sh"
        ", XF86Display, exec, ~/.config/scripts/monitors.sh"
        ", XF86Favorites, exec, $menu"
        ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
        "CTRL ALT, TAB, hyprexpo:expo, toggle"
      ];
      gestures = [
        "4, horizontal, workspace"
        "4, up, dispatcher, hyprexpo:expo, on"
        "4, down, dispatcher, hyprexpo:expo, off"
      ];
    };
    inputs.touchpad.enable = true;
    insomnia.enable = true;
    nautilus.enable = true;
    networking = {
      enable = true;
      hostname = hostname;
    };
    playstation.enable = true;
    printing.enable = true;
    steam.enable = true;
    virtualization = {
      virtualbox.enable = false;
      qemu.enable = false;
    };
    tmux.enable = true;
    thunderbird.enable = true;
    sddm.enable = true;
    waybar.enable = true;
    waybar.theme = "rose";
    wofi.enable = true;
    zed.enable = true;
    zen.enable = true;
  };

  users.users.${username} = {
    isNormalUser = true;
    description = mainUser.name;
    extraGroups = [
      "wheel"
      "docker"
    ];
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = stateVersion;
}
