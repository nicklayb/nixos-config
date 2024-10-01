{ config, lib, pkgs, ... }: {
  options = {
    mods.bluetooth = {
      enable = lib.mkEnableOption "Enables bluetooth";
    };
  };
  config = lib.mkIf config.mods.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
