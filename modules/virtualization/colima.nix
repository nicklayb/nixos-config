{
  config,
  lib,
  pkgs,
  username,
  ...
}:
{
  options = {
    mods.virtualization.colima = {
      enable = lib.mkEnableOption "Enables Colima";
    };
  };
  config = lib.mkIf config.mods.virtualization.colima.enable {
    environment.systemPackages = [
      pkgs.docker
      pkgs.colima
    ];
    launchd.agents."colima.default" = {
      command = "${pkgs.colima}/bin/colima start --foreground";
      serviceConfig = {
        Label = "com.colima.default";
        RunAtLoad = true;
        KeepAlive = true;

        StandardOutPath = "/Users/${username}/.colima/default/daemon/launchd.stdout.log";
        StandardErrorPath = "/Users/${username}/.colima/default/daemon/launchd.stderr.log";

        EnvironmentVariables = {
          PATH = "${pkgs.colima}/bin:${pkgs.docker}/bin:/usr/bin:/bin:/usr/sbin:/sbin";
        };
      };
    };
  };
}
