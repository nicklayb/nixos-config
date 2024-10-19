{ config, lib, pkgs, mainUser, ... }: {
  options = {
    mods.xfce = {
      enable = lib.mkEnableOption "Enables XFCE";
    };
  };
  config = lib.mkIf config.mods.xfce.enable {
    services.xserver.enable = true;
    services.xserver.desktopManager = {
      xfce.enable = true;
    };

    services.displayManager.defaultSession = "xfce";
  };
}
