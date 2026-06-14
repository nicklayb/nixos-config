{
  pkgs,
  stateVersion,
  mainUser,
  username,
  hostname,
  ...
}:
let
  wallpaperLeft = "/home/${username}/.background-left";
  wallpaperRight = "/home/${username}/.background-right";
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  bundles.music.enable = true;

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  mods = {
    _1password.enable = true;
    alacritty.enable = true;
    blender.enable = true;
    bluetooth.enable = true;
    docker.enable = true;
    deluge.enable = true;
    matrix.enable = true;
    gimp.enable = true;
    heroic.enable = true;
    hyprland = {
      enable = true;
      monitor = [
        "DP-2,2560x1440@144.01Hz,1440x600,1" # ASUS
        "DP-3,2560x1440@144.00Hz,0x0,1,transform, 3" # KOORUI
        "Unknown-1,disable"
      ];
      wallpapers = [
        "DP-3,${wallpaperLeft}"
        "DP-2,${wallpaperRight}"
      ];
      wallpaperPreloads = [
        wallpaperLeft
        wallpaperRight
      ];
      extraBindings = [
        # "CTRL ALT, TAB, hyprexpo:expo, toggle"
      ];
    };
    inputs.touchpad.enable = true;
    nautilus.enable = true;
    networking = {
      enable = true;
      hostname = hostname;
    };
    obs_studio = {
      enable = true;
      gpu = "nvidia";
    };
    printing.enable = true;
    sddm.enable = true;
    steam.enable = true;
    thunderbird.enable = true;
    waybar.enable = true;
    waybar.theme = "rose";
    wofi.enable = true;
    zen.enable = true;
  };

  users.users.${username} = {
    isNormalUser = true;
    description = mainUser.name;
    extraGroups = [
      "wheel"
      "docker"
    ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = [
    pkgs.godot_4
  ];

  system.stateVersion = stateVersion;
}
