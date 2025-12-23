{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    mods.thunderbird = {
      enable = lib.mkEnableOption "Enables thunderbird";
    };
  };
  config = lib.mkIf config.mods.thunderbird.enable {
    environment.systemPackages = [
      pkgs.thunderbird
    ];
  };
}
