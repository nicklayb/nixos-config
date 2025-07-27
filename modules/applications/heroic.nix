{ config, lib, pkgs, ... }: {
  options = {
    mods.heroic = {
      enable = lib.mkEnableOption "Enables Heroic";
    };
  };
  config = lib.mkIf config.mods.heroic.enable {
    environment.systemPackages = [
      # Currently having an issue with Electron on stable 24.11
      pkgs.heroic
    ];
    programs.gamemode.enable = true;
    programs.gamescope.enable = true;
  };
}
