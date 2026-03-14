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
        };
      };
    };
}
