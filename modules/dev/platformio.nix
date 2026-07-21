{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    mods.platformio = {
      enable = lib.mkEnableOption "Enables platformio";
    };
  };
  config = lib.mkIf config.mods.platformio.enable {
    environment.systemPackages = [ pkgs.platformio ];
    services.udev.packages = [ pkgs.platformio ];
  };
}
