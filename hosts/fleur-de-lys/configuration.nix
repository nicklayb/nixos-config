{ pkgs, stateVersion, username, mainUser, home-manager, ... }:

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
  mods.hyprland.wallpapers = [ "DP-3,/home/${username}/.background" ];
  mods.nautilus.enable = true;
  mods.sddm.enable = true;
  mods.waybar.enable = true;
  mods.wofi.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    description = mainUser.name;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = stateVersion;
}

