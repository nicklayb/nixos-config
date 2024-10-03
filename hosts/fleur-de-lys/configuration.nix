{ pkgs, stateVersion, mainUser, home-manager, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  mods._1password.enable = true;
  mods.alacritty.enable = true;
  mods.docker.enable = true;
  mods.hyprland.enable = true;
  mods.hyprland.monitor = [
    "DP-3,2560x1440@144.01Hz,0x0,1"
  ];
  mods.hyprland.wallpapers = ["DP-3,/home/${mainUser.username}/.background"];
  mods.nautilus.enable = true;

  users.users.${mainUser.username} = {
    isNormalUser = true;
    description = mainUser.name;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = stateVersion;
}

