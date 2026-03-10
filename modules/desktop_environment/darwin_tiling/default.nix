{
  config,
  lib,
  pkgs,
  username,
  ...
}:
{
  options = {
    mods.darwin_tiling = {
      yabai = {
        enable = lib.mkEnableOption "Enables yabai";
        gaps = lib.mkOption {
          type = lib.types.int;
          default = 3;
          description = "The size of the gaps between windows in pixels.";
        };
      };

      skhd = {
        enable = lib.mkEnableOption "Enables skhd";
      };

      sketchybar = {
        enable = lib.mkEnableOption "Enables sketchybar";
      };
    };
  };
  config =
    let
      yabai = config.mods.darwin_tiling.yabai;
      skhd = config.mods.darwin_tiling.skhd;
      sketchybar = config.mods.darwin_tiling.sketchybar;
      sketchybarTheme = import ./sketchybar/theme.nix { config = sketchybar; };
    in
    lib.mkIf yabai.enable {
      services.yabai = {
        enable = true;
        enableScriptingAddition = true;
        package = pkgs.yabai;
        config = import ./yabai.nix { config = yabai; };
      };
    }
    // lib.mkIf skhd.enable {

      services.skhd = {
        enable = true;
        package = pkgs.skhd;
        skhdConfig = import ./skhd.nix { config = skhd; };
      };
    }
    // lib.mkIf sketchybar.enable {
      services.sketchybar = {
        enable = true;
        config = import ./sketchybar.nix {
          config = sketchybar;
          theme = sketchybarTheme;
        };
      };

      home-manager.users.${username} = {
        home.file.".config/sketchybar/plugins/spaces.sh" = {
          text = import ./sketchybar/plugins/spaces.nix {
            config = sketchybar;
            theme = sketchybarTheme;
          };
          executable = true;
        };
      };
    };
}
