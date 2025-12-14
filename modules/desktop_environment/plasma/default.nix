{ config, lib, ... }: {
  options = {
    mods.plasma = {
      enable = lib.mkEnableOption "Enables Plasma";
      withSddm = lib.mkEnableOption "Include SDDM";
    };
  };
  config = lib.mkIf config.mods.plasma.enable {
    services.xserver.enable = true;
    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm = lib.mkIf config.mods.plasma.withSddm { enable = true; };
  };
}
