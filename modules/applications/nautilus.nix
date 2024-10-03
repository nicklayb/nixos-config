{ config, lib, pkgs, ... }: {
  options = {
    mods.nautilus = {
      enable = lib.mkEnableOption "Enables Nautilus";
    };
  };
  config = lib.mkIf config.mods.nautilus.enable {
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    environment.systemPackages = [
      pkgs.gnome.nautilus
    ];
  };
}
