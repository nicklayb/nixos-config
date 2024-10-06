{ pkgs, stateVersion, mainUser, users, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  mods._1password.enable = true;
  mods.alacritty.enable = true;
  mods.bluetooth.enable = false;
  mods.docker.enable = true;
  mods.firefox.enable = true;
  mods.hyprland.enable = true;
  mods.hyprland.monitor = [
    "DP-2,2560x1440@144.01Hz,0x0,1"
    "Unknown-1,disable"
  ];
  mods.hyprland.wallpapers = ["DP-2,/home/${mainUser.username}/.background"];
  mods.inputs.touchpad.enable = true;
  mods.nautilus.enable = true;
  mods.steam.enable = true;
  mods.waybar.enable = true;
  mods.wofi.enable = true;

  users = import ../tools/create_users.nix { users = users; pkgs = pkgs; };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = stateVersion;
}

