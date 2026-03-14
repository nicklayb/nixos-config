{
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:
{
  options = {
    mods.darwin_tiling = {
      skhd = {
        enable = lib.mkEnableOption "Enables skhd";
      };
    };
  };
  config =
    let
      skhd = config.mods.darwin_tiling.skhd;

      spaces = [
        "1"
        "2"
        "3"
        "4"
        "5"
        "6"
        "7"
        "8"
        "9"
      ];
    in
    lib.mkIf skhd.enable {

      services.skhd = {
        enable = true;
        package = pkgs.skhd;
        skhdConfig = ''
          # move focused window
          cmd + alt - left : yabai -m window --warp west
          cmd + alt - down : yabai -m window --warp south
          cmd + alt - up : yabai -m window --warp north
          cmd + alt - right : yabai -m window --warp east

          cmd - left : yabai -m window --focus west
          cmd - down : yabai -m window --focus south
          cmd - up : yabai -m window --focus north
          cmd - right : yabai -m window --focus east

          ${builtins.concatStringsSep "\n" (
            map (space: ''
              lalt - ${space} : yabai -m space --focus ${space}
              lalt + shift - ${space} : yabai -m window --space ${space}
            '') spaces
          )}
        '';
      };
    };
}
