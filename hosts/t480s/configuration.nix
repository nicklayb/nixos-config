{ pkgs, stateVersion, mainUser, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  mods.steam.enable = true;
  mods.nautilus.enable = true;
  mods.hyprland.enable = true;
  mods.docker.enable = true;
  mods._1password.enable = true;

  programs.firefox.enable = true;

  users.users.${mainUser.username} = {
    isNormalUser = true;
    description = mainUser.name;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    firefox
    neovim
    krita
    pavucontrol
    vlc
    alacritty
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = stateVersion;
}

