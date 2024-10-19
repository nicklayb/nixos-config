{ pkgs, stateVersion, mainUser, home-manager, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  mods._1password.enable = true;
  mods.alacritty.enable = true;
  mods.ardour.enable = true;
  mods.docker.enable = true;
  mods.firefox.enable = true;
  mods.nautilus.enable = true;
  mods.inputs.touchpad.enable = true;
  mods.xfce.enable = true;

  users.users.${mainUser.username} = {
    isNormalUser = true;
    description = mainUser.name;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = stateVersion;
}

