{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    mods.darwin_tiling = {
      yabai = {
        enable = lib.mkEnableOption "Enables yabai";
        gaps = lib.mkOption {
          type = lib.types.int;
          default = 5;
          description = "The size of the gaps between windows in pixels.";
        };
        statusBar = lib.mkOption {
          type = lib.types.str;
          default = "main:0:0";
          description = "The status bar configuration";
        };
      };
    };
  };
  config =
    let
      yabai = config.mods.darwin_tiling.yabai;
    in
    lib.mkIf yabai.enable {
      #environment.systemPackages = [ pkgs.yabai ];
      services.yabai = {
        enable = true;
        enableScriptingAddition = true;
        package = pkgs.yabai;
        config = {
          focus_follows_mouse = "autofocus";
          layout = "bsp";
          split_ratio = 0.5;
          auto_balance = "off";
          top_padding = yabai.gaps;
          bottom_padding = yabai.gaps;
          left_padding = yabai.gaps;
          right_padding = yabai.gaps;
          window_gap = yabai.gaps;
          window_placement = "second_child";
          external_bar = yabai.statusBar;
        };
      };
    };
}
