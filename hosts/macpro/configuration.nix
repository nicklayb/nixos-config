{
  pkgs,
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

  mods = {
    _1password.enable = true;
    alacritty.enable = true;
    blender.enable = true;
    bluetooth.enable = true;
    docker.enable = true;
    deluge.enable = true;
    gimp.enable = true;
    hyprland = {
      enable = true;
      monitor = [
        "DP-1,2560x1440@144.01Hz,1440x600,1" # ASUS
        "DP-2,2560x1440@144.00Hz,0x0,1,transform, 3" # KOORUI
      ];
      wallpapers = [
        "DP-2,${wallpaperLeft}"
        "DP-1,${wallpaperRight}"
      ];
      wallpaperPreloads = [
        wallpaperLeft
        wallpaperRight
      ];
      extraBindings = [
        "CTRL ALT, TAB, hyprexpo:expo, toggle"
      ];
    };
    nautilus.enable = true;
    networking = {
      enable = true;
      hostname = hostname;
    };
    obs_studio = {
      enable = true;
      gpu = "amd";
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
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = [
    pkgs.godot_4
  ];

  system.stateVersion = "25.11";
}
