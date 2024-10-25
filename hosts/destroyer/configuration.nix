{ pkgs, stateVersion, mainUser, home-manager, ... }:
let
  wallpaperLeft = "/home/${mainUser.username}/.background-left";
  wallpaperRight = "/home/${mainUser.username}/.background-right";
in
{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  mods._1password.enable = true;
  mods.alacritty.enable = true;
  mods.bluetooth.enable = true;
  mods.docker.enable = true;
  mods.firefox.enable = true;
  mods.firefox.theme = "textfox-dev";
  mods.hyprland.enable = true;
  mods.hyprland.monitor = [
    "DP-2,2560x1440@144.01Hz,2560x0,1"
    "DP-3,2560x1440@144.00Hz,0x0,1"
    "Unknown-1,disable"
  ];
  mods.hyprland.wallpapers = [
    "DP-3,${wallpaperLeft}"
    "DP-2,${wallpaperRight}"
  ];
  mods.hyprland.wallpaperPreloads = [ wallpaperLeft wallpaperRight ];
  mods.inputs.touchpad.enable = true;
  mods.nautilus.enable = true;
  mods.steam.enable = true;
  mods.waybar.enable = true;
  mods.waybar.theme = "rose";
  mods.wofi.enable = true;

  users.users.${mainUser.username} = {
    isNormalUser = true;
    description = mainUser.name;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = stateVersion;
}

