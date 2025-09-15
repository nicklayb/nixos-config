{ pkgs, stateVersion, mainUser, username, home-manager, ... }:
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
  mods.hyprland = {
    enable = true;
    monitor = [
      "eDP-1,1920x1080@60.00Hz,0x0,1"
    ];
    extraBindings = [
      ", F4, exec, ~/.config/touchscreen/toggle.sh"
    ];
  };
  mods.nautilus.enable = true;
  mods.printing.enable = true;
  mods.inputs.touchscreen.enable = true;
  mods.waybar.enable = true;
  mods.waybar.theme = "rose";
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

