{ config, lib, pkgs, mainUser, ... }: {
  options = {
    mods.plasma = {
      enable = lib.mkEnableOption "Enables Plasma";
    };
  };
  config = lib.mkIf config.mods.plasma.enable {
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
  };
}
