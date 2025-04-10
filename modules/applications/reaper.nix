{ config, lib, mainUser, pkgs, ... }: {
  options = {
    mods.reaper = {
      enable = lib.mkEnableOption "Enables Reaper";
    };
  };
  config = lib.mkIf config.mods.reaper.enable {
    environment.systemPackages = [
      pkgs.reaper
    ];
  };
}
