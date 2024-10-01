{ config, lib, pkgs, ... }: {
  options = {
    mods.steam = {
      enable = lib.mkEnableOption "Enables Steam";
    };
  };
  config = lib.mkIf config.mods.steam.enable {
    programs.steam.enable = true;
  };
}
