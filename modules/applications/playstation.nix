{ config, lib, pkgs, ... }: {
  options = {
    mods.playstation = {
      enable = lib.mkEnableOption "Enables Playstation Remote";
    };
  };
  config = lib.mkIf config.mods.playstation.enable {
    environment.systemPackages = [
      pkgs.chiaki-ng
    ];
  };
}
