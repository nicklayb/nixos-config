{ config, lib, mainUser, pkgs, ... }: {
  options = {
    mods.deluge = {
      enable = lib.mkEnableOption "Enables Deluge";
    };
  };
  config = lib.mkIf config.mods.deluge.enable {
    environment.systemPackages = [
      pkgs.deluge-gtk
    ];
  };
}
