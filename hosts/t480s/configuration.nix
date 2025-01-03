{ pkgs, stateVersion, mainUser, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      inputs.nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"
    ];

  mods._1password.enable = true;
  mods.alacritty.enable = true;
  mods.bluetooth.enable = true;
  mods.dbeaver.enable = true;
  mods.docker.enable = true;
  mods.firefox.enable = true;
  mods.hyprland.enable = true;
  mods.hyprland.monitor = [
    "eDP-1,1920x1080@60.00Hz,0x1440,1"
    "HDMI-A-2,2560x1440@120.00Hz,0x0,1"
  ];
  mods.hyprland.wallpapers = [
    "eDP-1,/home/${mainUser.username}/.background"
    "HDMI-A-2,/home/${mainUser.username}/.background-external"
  ];
  mods.hyprland.wallpaperPreloads = [
    "/home/${mainUser.username}/.background"
    "/home/${mainUser.username}/.background-external"
  ];
  mods.inputs.touchpad.enable = true;
  mods.insomnia.enable = true;
  mods.nautilus.enable = true;
  mods.steam.enable = true;
  mods.waybar.enable = true;
  mods.waybar.theme = "rose";
  mods.wofi.enable = true;
  mods.zen.enable = true;

  services.open-fprintd.enable = true;

  security.polkit.enable = true;

  security.pam.services.sddm.fprintAuth = true;

  services."06cb-009a-fingerprint-sensor" = {                                 
    enable = true;                                                            
    backend = "python-validity";                                              
  }; 

  users.users.${mainUser.username} = {
    isNormalUser = true;
    description = mainUser.name;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = stateVersion;
}

