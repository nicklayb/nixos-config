{ pkgs, stateVersion, username, mainUser, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./fingerprint.nix
    ];

  environment.systemPackages = [
    pkgs.obs-studio
    (pkgs.nnn.override { withNerdIcons = true; })
  ];

  mods._1password.enable = true;
  mods.alacritty.enable = true;
  mods.bluetooth.enable = true;
  mods.dbeaver.enable = true;
  mods.docker.enable = true;
  mods.firefox.enable = true;
  mods.github.enable = true;
  mods.hyprland.enable = true;
  mods.hyprland.monitor = [
    "eDP-1,1920x1080@60.00Hz,0x1440,1"
    "HDMI-A-2,2560x1440@120.00Hz,0x0,1"
  ];
  mods.hyprland.wallpapers = [
    "eDP-1,/home/${username}/.background"
    "HDMI-A-2,/home/${username}/.background-external"
  ];
  mods.hyprland.wallpaperPreloads = [
    "/home/${username}/.background"
    "/home/${username}/.background-external"
  ];
  mods.hyprland.extraBindings = [
    "$mainMod SHIFT, M, exec, ~/.config/scripts/monitors.sh"
  ];
  mods.inputs.touchpad.enable = true;
  mods.insomnia.enable = true;
  mods.nautilus.enable = true;
  mods.playstation.enable = true;
  mods.printing.enable = true;
  mods.steam.enable = true;
  mods.virtualbox.enable = true;
  mods.tmux.enable = true;
  mods.waybar.enable = true;
  mods.waybar.theme = "rose";
  mods.wofi.enable = true;
  mods.zen.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    description = mainUser.name;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = stateVersion;
}

