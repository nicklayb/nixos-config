{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    mods.gimp = {
      enable = lib.mkEnableOption "Enables Gimp";
    };
  };
  config = lib.mkIf config.mods.gimp.enable {
    environment.systemPackages = [
      pkgs.gimp
    ];
  };
}
