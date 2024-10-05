{ config, lib, pkgs, mainUser, ... }: {
  options = {
    mods.flatpak = {
      enable = lib.mkEnableOption "Enables Flatpak";
    };
  };
  config = lib.mkIf config.mods.flatpak.enable {
    services.flatpak.enable = true;
  };
}
