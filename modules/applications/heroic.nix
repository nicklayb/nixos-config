{ config, lib, unstable-pkgs, ... }: {
  options = {
    mods.heroic = {
      enable = lib.mkEnableOption "Enables Heroic";
    };
  };
  config = lib.mkIf config.mods.heroic.enable {
    environment.systemPackages = [
      unstable-pkgs.heroic
    ];
    programs.gamemode.enable = true;
    programs.gamescope.enable = true;
  };
}
