{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    mods.remmina = {
      enable = lib.mkEnableOption "Enables Remmina";
    };
  };
  config = lib.mkIf config.mods.remmina.enable {
    environment.systemPackages = [
      pkgs.remmina
    ];
  };
}
