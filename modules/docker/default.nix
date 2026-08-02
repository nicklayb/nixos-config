{
  config,
  lib,
  unstable-pkgs,
  ...
}:
{
  options = {
    mods.docker = {
      enable = lib.mkEnableOption "Enables docker";
    };
  };
  config = lib.mkIf config.mods.docker.enable {
    virtualisation.docker = {
      enable = true;
      package = unstable-pkgs.docker;
      daemon.settings = {
        insecure-registries = [
          "hal:5000"
        ];
      };
    };
  };
}
