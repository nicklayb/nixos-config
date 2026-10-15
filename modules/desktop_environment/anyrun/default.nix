{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  mkPlugins = builtins.map (plugin: "${pkgs.anyrun}/lib/${plugin}.so");
in
{
  options = {
    mods.anyrun = {
      enable = lib.mkEnableOption "Enables Anyrun";
    };
  };
  config = lib.mkIf config.mods.anyrun.enable {
    home-manager.users.${username} = {
      programs.anyrun = {
        enable = true;
        config = {
          plugins = mkPlugins [
            "libapplications"
            "libsymbols"
            "librink"
            "libwebsearch"
            "libactions"
          ];
        };
        extraCss = import ./css.nix { };
      };
      # Currently not included in Home Manager, remove once it lands
      systemd.user.services.anyrun = {
        Unit = {
          Description = "Anyrun daemon";
          PartOf = "graphical-session.target";
          After = "graphical-session.target";
        };

        Service = {
          Type = "simple";
          ExecStart = "${lib.getExe pkgs.anyrun} daemon";
          Restart = "on-failure";
          KillMode = "process";
        };

        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
    };
  };
}
