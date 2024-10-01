{ config, lib, pkgs, ... }: {
  options = {
    mods.docker = {
      enable = lib.mkEnableOption "Enables docker";
    };
  };
  config = lib.mkIf config.mods.docker.enable {
    virtualisation.docker.enable = true;
  };
}
