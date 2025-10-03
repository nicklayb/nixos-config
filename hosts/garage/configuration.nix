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
    monitor = [
      "eDP-1,1920x1080@60.00Hz,0x0,1"
    ];
    extraBindings = [
      ", F4, exec, ~/.config/touchscreen/toggle.sh"
    ];
    wallpapers = [
      "eDP-1,/home/${username}/.background"
    ];
    wallpaperPreloads = [
      "/home/${username}/.background"
    ];
    hypridle = {
      timers = {
        lock = "99999";
        sleep = "99999";
      };
    };
  };
  mods.nautilus.enable = true;
  mods.printing.enable = true;
  mods.inputs.touchscreen.enable = true;
  mods.wofi.enable = true;
  mods.zen.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    description = mainUser.name;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = stateVersion;
}

