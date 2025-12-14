{ config, lib, pkgs, ... }: {
  options = {
    mods.bluetooth = {
      enable = lib.mkEnableOption "Enables bluetooth";
      blueman = lib.mkOption {
        type = lib.types.bool;
        description = "Enables Blueman GUI";
        default = true;
      };
    };
  };
  config = let
      blueman = 
        if config.mods.bluetooth.blueman then 
          [ pkgs.blueman ]
        else
          [];
    in lib.mkIf config.mods.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    environment.systemPackages = blueman;
  };
}
