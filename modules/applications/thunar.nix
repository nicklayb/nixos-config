{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    mods.thunar = {
      enable = lib.mkEnableOption "Enables thunar";
    };
  };
  config = lib.mkIf config.mods.thunar.enable {
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    environment.systemPackages = [
      pkgs.thunar
    ];
  };
}
