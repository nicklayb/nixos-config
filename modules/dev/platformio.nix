{
  config,
  lib,
  pkgs,
  ...
}:
let
  adafruit_pro_micro = {
    vendorId = "239a";
    producId = "8029";
  };
in
{
  options = {
    mods.platformio = {
      enable = lib.mkEnableOption "Enables platformio";
    };
  };
  config = lib.mkIf config.mods.platformio.enable {
    environment.systemPackages = [ pkgs.platformio ];
    services.udev.packages = [
      pkgs.platformio
      pkgs.platformio-core.udev
      pkgs.openocd
    ];

    services.udev.extraRules = ''
      SUBSYSTEM=="tty", ATTRS{idVendor}=="${adafruit_pro_micro.vendorId}", ATTRS{idProduct}=="${adafruit_pro_micro.producId}", MODE="0666"
    '';
  };
}
