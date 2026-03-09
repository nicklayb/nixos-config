{
  config,
  lib,
  username,
  pkgs,
  ...
}:
{
  options = {
    mods.alacritty = {
      enable = lib.mkEnableOption "Enables Alacritty";

      fontSize = lib.mkOption {
        description = "Size of the font";
        default = 11;
        type = lib.types.int;
      };

      fontFamily = lib.mkOption {
        description = "Font family to use in Alacritty";
        default = "CaskaydiaCove Nerd Font Mono";
        type = lib.types.str;
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
          font =
            let
              font = {
                family = config.mods.alacritty.fontFamily;
              };
            in
            {
              size = config.mods.alacritty.fontSize;
              bold = font;
              bold_italic = font;
              italic = font;
              normal = font;
            };
          window = (
            if pkgs.stdenv.isLinux then
              {
                decorations = "Full";
                opacity = 1;
              }
            else
              {
                decorations = "buttonless";
                opacity = 1;
                option_as_alt = "OnlyLeft";
              }
          );
        };
      };
    };
  };
}
