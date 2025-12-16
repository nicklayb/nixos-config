{ pkgs, stateVersion, mainUser, username, hostname, ... }:
let
  wallpaperLeft = "/home/${username}/.background-left";
  wallpaperRight = "/home/${username}/.background-right";
in
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  bundles.music.enable = true;

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  mods._1password.enable = true;
  mods.alacritty.enable = true;
  mods.blender.enable = true;
  mods.bluetooth.enable = true;
  mods.docker.enable = true;
  mods.deluge.enable = true;
  mods.firefox.enable = true;
  mods.firefox.theme = "textfox-dev";
  mods.heroic.enable = true;
  mods.hyprland = {
    enable = true;
    monitor = [
      "DP-2,2560x1440@144.01Hz,0x0,1"
      "DP-3,2560x1440@144.00Hz,0x1440,1"
      "Unknown-1,disable"
    ];
    wallpapers = [
      "DP-3,${wallpaperLeft}"
      "DP-2,${wallpaperRight}"
    ];
    wallpaperPreloads = [ wallpaperLeft wallpaperRight ];
    extraBindings = [
      "CTRL ALT, TAB, hyprexpo:expo, toggle"
    ];
  };
  mods.inputs.touchpad.enable = true;
  mods.nautilus.enable = true;
  mods.networking = {
    enable = true;
    hostname = hostname;
  };
  mods.printing.enable = true;
  mods.sddm.enable = true;
  mods.steam.enable = true;
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

  environment.systemPackages = [
    pkgs.godot_4
  ];

  system.stateVersion = stateVersion;
}

