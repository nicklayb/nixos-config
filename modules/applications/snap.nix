{ config, lib, pkgs, ... }: {
  options = {
    mods.snap = {
      enable = lib.mkEnableOption "Enables snap";
    };
  };
  config = lib.mkIf config.mods.snap.enable {
    services.snap.enable = true;
  };
}
