{ config, lib, mainUser, pkgs, ... }: {
  options = {
    mods.insomnia = {
      enable = lib.mkEnableOption "Enables Insomnia";
    };
  };
  config = lib.mkIf config.mods.insomnia.enable {
    environment.systemPackages = [
      pkgs.insomnia
    ];
  };
}
