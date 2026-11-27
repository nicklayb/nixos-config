{
  config,
  lib,
  pkgs,
  username,
  ...
}:
{
  options = {
    mods.node-exporter = {
      enable = lib.mkEnableOption "Enables node-exporter";
    };
  };
  config = lib.mkIf config.mods.node-exporter.enable {
    services.prometheus.exporters.node = {
      enable = true;
      port = 9100;
      openFirewall = true;
      enabledCollectors = [ "systemd" ];
    };
  };
}
