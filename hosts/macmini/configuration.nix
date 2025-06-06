{ pkgs, stateVersion, username, mainUser, ... }:

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
  mods.hyprland.monitor = [ "HDMI-A-2,2560x1440@74.97Hz,0x0,1" ];
  mods.hyprland.wallpapers = [ "HDMI-A-2,/home/${username}/.background" ];
  mods.nautilus.enable = true;
  mods.plasma.enable = true;
  mods.waybar.enable = true;
  mods.waybar.theme = "rose";
  mods.wofi.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    description = mainUser.name;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  users.users.evelynn = {
    isNormalUser = true;
    description = "Eve-Lynn Laforme";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = stateVersion;
}

