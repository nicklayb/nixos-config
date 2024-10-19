{ config, lib, mainUser, pkgs, ... }: {
  options = {
    mods.ardour = {
      enable = lib.mkEnableOption "Enables Ardour";
    };
  };
  config = lib.mkIf config.mods.ardour.enable {
    environment.systemPackages = [
      pkgs.ardour
    ];
  };
}
