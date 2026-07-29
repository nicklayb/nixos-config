{
  pkgs,
  mainUser,
  username,
  hostname,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  bundles.music.enable = true;

  mods = {
    _1password.enable = true;
    alacritty.enable = true;
    blender.enable = true;
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Privacy = "device";
          JustWorksRepairing = "always";
          Class = "0x000100";
          FastConnectable = "true";
        };
      };
    };
    docker.enable = true;
    deluge.enable = true;
    gimp.enable = true;
    hyprland = {
      enable = true;
      monitor = [
        "DP-1,2560x1440@144.01Hz,1440x600,1" # ASUS
        "DP-2,2560x1440@144.00Hz,0x0,1,transform, 3" # KOORUI
      ];
      hyprpaper = {
        randomWallpapers = {
          enable = true;
          query = "mountains";
          mapping = {
            "/home/${username}/.background-left" = [ "DP-2" ];
            "/home/${username}/.background-right" = [ "DP-1" ];
          };
        };
      };
      extraBindings = [
        # "CTRL ALT, TAB, hyprexpo:expo, toggle"
      ];
    };
    nautilus.enable = true;
    networking = {
      enable = true;
      hostname = hostname;
    };
    obs_studio = {
      enable = true;
      gpu = "amd";
    };
    printing.enable = true;
    sddm.enable = true;
    steam.enable = true;
    thunderbird.enable = true;
    tmux.enable = true;
    waybar.enable = true;
    waybar.theme = "rose";
    wofi.enable = true;
    zen.enable = true;
  };

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

  environment.systemPackages = [
    pkgs.godot_4
    pkgs.bambu-studio
  ];

  system.stateVersion = "25.11";
}
