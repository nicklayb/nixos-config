{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    mods.darwin_tiling = {
      spacebar = {
        enable = lib.mkEnableOption "Enables spacebar";
      };
    };
  };
  config =
    let
      spacebar = config.mods.darwin_tiling.spacebar;
    in
    lib.mkIf spacebar.enable {
      services.spacebar = {
        enable = true;
        package = pkgs.spacebar;
        config = {
          position = "bottom";
          height = 26;
          space_icon_strip = "1 2 3 4 5 6 7 8 9";
          background_color = "0xff303446";
          text_color = "0xffcad3f5";
          text_font = ''"CaskaydiaCove Nerd Font Mono:Regular:12.0"'';
          display_separator = true;
          display_separator_icon = "►";
        };
      };
    };
}
