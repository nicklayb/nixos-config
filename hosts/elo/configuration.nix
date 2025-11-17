{ pkgs, stateVersion, mainUser, username, home-manager, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  mods._1password.enable = true;
  mods.alacritty.enable = true;
  mods.docker.enable = true;
  mods.firefox.enable = true;
  mods.hyprland = {
    enable = true;
    gaps = 0;
    dimInactive = false;
    hypridle = {
      timers = {
        lock = "99999";
        sleep = "99999";
      };
    };
  };
  mods.nautilus.enable = true;
  mods.inputs.touchscreen.enable = true;
  mods.tmux.enable = true;
  mods.wofi.enable = true;
  mods.zen.enable = true;

  environment.systemPackages = [
    pkgs.jq
    pkgs.just
  ];

  users.users.${username} = {
    isNormalUser = true;
    description = mainUser.name;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = stateVersion;
}

