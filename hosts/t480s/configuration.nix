{ pkgs, stateVersion, mainUser, ... }:

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
  mods.hyprland.enable = true;
  mods.hyprland.monitor = [ "eDP-1,1920x1080@60.00Hz,0x0,1" ];
  mods.hyprland.wallpapers = ["eDP-1,/home/${mainUser.username}/.background"];
  mods.inputs.touchpad.enable = true;
  mods.nautilus.enable = true;
  mods.steam.enable = true;

  users.users.${mainUser.username} = {
    isNormalUser = true;
    description = mainUser.name;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = stateVersion;
}

