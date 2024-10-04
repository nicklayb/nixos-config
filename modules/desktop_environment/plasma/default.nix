{ config, lib, pkgs, mainUser, ... }: {
  options = {
    mods.plasma = {
      enable = lib.mkEnableOption "Enables Plasma";
    };
  };
  config = lib.mkIf config.mods.plasma.enable {
    services.desktopManager.plasma6.enable = true;
  };
}
