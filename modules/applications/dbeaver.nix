{ config, lib, mainUser, pkgs, ... }: {
  options = {
    mods.dbeaver = {
      enable = lib.mkEnableOption "Enables dbeaver";
    };
  };
  config = lib.mkIf config.mods.dbeaver.enable {
    environment.systemPackages = [
      pkgs.dbeaver-bin
    ];
  };
}
