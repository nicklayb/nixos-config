{
  pkgs,
  stateVersion,
  username,
  hostname,
  mainUser,
  system,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  environment.systemPackages = [
    pkgs.obs-studio
    pkgs.brightnessctl
    (pkgs.nnn.override { withNerdIcons = true; })
    inputs.plexm3u.packages.${system}.default
  ];

  home-manager.users.${username} = {
    xdg.configFile = {
      "hypr/scripts/lidclosed".source = ./scripts/lidclosed.sh;
    };
  };

  mods._1password.enable = true;
  mods.alacritty = {
    enable = true;
    fontSize = 10;
  };
  mods.bluetooth.enable = true;
  mods.dbeaver.enable = true;
  mods.deluge.enable = true;
  mods.docker.enable = true;
  mods.firefox.enable = true;
  mods.github.enable = true;
  mods.hyprland = {
    enable = true;
    hyprlock = {
      battery = true;
    };
    monitor = [
      "eDP-1,1920x1080@60.00Hz,0x1440,1"
      "HDMI-A-2,2560x1440@120.00Hz,0x0,1"
      "DP-1,3440x1440@120.00Hz,0x0,1"
    ];
    wallpapers = [
      "eDP-1,/home/${username}/.background"
      "HDMI-A-2,/home/${username}/.background-external"
      "DP-1,/home/${username}/.background-external"
    ];
    wallpaperPreloads = [
      "/home/${username}/.background"
      "/home/${username}/.background-external"
    ];
    extraBindingsL = [
      ", switch:on:Lid Switch, exec, ~/.config/hypr/scripts/lidclosed"
      ", switch:off:Lid Switch, exec, hyprctl keyword monitor \"e-DP-1, enable\" & hyprctl reload"
    ];
    extraBindings = [
      "$mainMod SHIFT, M, exec, ~/.config/scripts/monitors.sh"
      ", XF86Display, exec, ~/.config/scripts/monitors.sh"
      ", XF86Favorites, exec, $menu"
      ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
      ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
    ];
    gestures = [
      "4, horizontal, workspace"
      "4, up, dispatcher, hyprexpo:expo, on"
      "4, down, dispatcher, hyprexpo:expo, off"
    ];
  };
  mods.inputs.touchpad.enable = true;
  mods.insomnia.enable = true;
  mods.nautilus.enable = true;
  mods.networking = {
    enable = true;
    hostname = hostname;
  };
  mods.playstation.enable = true;
  mods.printing.enable = true;
  mods.steam.enable = true;
  mods.virtualization = {
    virtualbox.enable = false;
    qemu.enable = false;
  };
  mods.tmux.enable = true;
  mods.sddm.enable = true;
  mods.waybar.enable = true;
  mods.waybar.theme = "rose";
  mods.wofi.enable = true;
  mods.zed.enable = true;
  mods.zen.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    description = mainUser.name;
    extraGroups = [
      "wheel"
      "docker"
    ];
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = stateVersion;
}
