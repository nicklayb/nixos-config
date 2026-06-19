{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    mods.bluetooth = {
      enable = lib.mkEnableOption "Enables bluetooth";
      blueman = lib.mkOption {
        type = lib.types.bool;
        description = "Enables Blueman GUI";
        default = true;
      };
      settings = lib.mkOption {
        type = lib.types.attrsOf lib.types.attrs;
        description = "Bluetooth settings to be applied on startup";
      };
    };
  };
  config =
    let
      blueman = if config.mods.bluetooth.blueman then [ pkgs.blueman ] else [ ];
    in
    lib.mkIf config.mods.bluetooth.enable {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = config.mods.bluetooth.settings;
      };

      environment.systemPackages = blueman;
    };
}
