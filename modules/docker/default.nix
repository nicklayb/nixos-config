{ config, lib, ... }: {
  options = {
    mods.docker = {
      enable = lib.mkEnableOption "Enables docker";
    };
  };
  config = lib.mkIf config.mods.docker.enable {
    virtualisation.docker = {
      enable = true;
      daemon.settings = {
        insecure-registries = [
          "hal:5000"
        ];
      };
    };
  };
}
