{ pkgs, stateVersion, users, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  mods._1password.enable = true;
  mods.alacritty.enable = true;
  mods.docker.enable = true;
  mods.firefox.enable = true;
  mods.hyprland.enable = true;
  mods.hyprland.monitor = [
    "DP-3,2560x1440@144.01Hz,0x0,1"
  ];
  mods.nautilus.enable = true;
  mods.waybar.enable = true;
  mods.wofi.enable = true;

  users = import ../tools/create_users.nix { users = users; pkgs = pkgs; };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = stateVersion;
}

