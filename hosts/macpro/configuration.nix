{ pkgs, stateVersion, mainUser, home-manager, ... }:

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
  mods.hyprland.enable = false;
  mods.hyprland.monitor = [
    "DP-2,2560x1440@144.01Hz,0x0,1"
 ];
  mods.hyprland.wallpapers = ["DP-2,/home/${mainUser.username}/.background"];
  mods.plasma.enable = true;
  mods.nautilus.enable = false;
  mods.waybar.enable = false;
  mods.wofi.enable = false;

  users.users.${mainUser.username} = {
    isNormalUser = true;
    description = mainUser.name;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = stateVersion;
}

