{ pkgs, stateVersion, mainUser, username, ... }:
let
  wallpaper = "/home/${username}/.background";
in {
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
    gaps = 0;
    dimInactive = false;
    extraExecOnce = [
      "firefox ~/photo_boite_config/index.html --kiosk"
    ];
    monitor = [
      "eDP-1,1280x720@59.86Hz,0x0,1"
    ];
    wallpapers = [
      "eDP-1,${wallpaper}"
    ];
    wallpaperPreloads = [ wallpaper ];
    cursorInactiveTimeout = 1;
    hypridle = {
      timers = {
        lock = "99999";
        sleep = "99999";
      };
    };
    sddmSettings = {
      Autologin = {
        User = username;
      };
    };
  };
  mods.nautilus.enable = true;
  mods.inputs.touchscreen.enable = true;
  mods.tmux.enable = true;
  mods.wofi.enable = true;

  services.photo-boite = {
    enable = true;
    secretKeyBaseFile = "/home/${username}/photo_boite_config/SECRET_KEY_BASE";
    liveViewSaltFile = "/home/${username}/photo_boite_config/LIVE_VIEW_SALT";
    databaseUrlFile = "/home/${username}/photo_boite_config/PHOTO_BOITE_DATABASE_URL";
    releaseCookieFile = "/home/${username}/photo_boite_config/RELEASE_COOKIE";
    extraEnvironment = {
      PHOTOS_DIRECTORY = "/var/lib/photo-boite";
    };
    user = username;
    group = "wheel";
  };

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

