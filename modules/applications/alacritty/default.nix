{ config, lib, username, pkgs, ... }: {
  options = {
    mods.alacritty = {
      enable = lib.mkEnableOption "Enables Alacritty";
      fontSize = lib.mkOption {
        description = "Size of the font";
        default = 11;
        type = lib.types.int;
      };
    };
  };
  config = lib.mkIf config.mods.alacritty.enable {
    environment.systemPackages = [
      pkgs.alacritty
    ];

    home-manager.users.${username} = {
      programs.alacritty = {
        enable = true;
        settings = {
          cursor = {
            style = {
              blinking = "Always";
            };
          };
          font = {
            size = config.mods.alacritty.fontSize;
          };
          window = {
            decorations = "Full";
            opacity = 1;
          };
        };
      };
    };
  };
}
