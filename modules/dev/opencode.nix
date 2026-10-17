{
  config,
  lib,
  unstable-pkgs,
  username,
  ...
}:
let
  cfg = config.mods.opencode;
in
{
  options = {
    mods.opencode = {
      enable = lib.mkEnableOption "Enables OpenCode";
      config = lib.mkOption {
        type = lib.types.nullOr lib.types.attrsOf lib.types.any;
        default = null;
        description = "OpenCode configuration as a JSON object.";
    };
  };
  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        environment.systemPackages = [ unstable-pkgs.opencode ];
      }
      (lib.mkIf (cfg.config != null) {
        home-manager.users.${username} = {
          xdg.configFile."opencode/opencode.json".text = builtins.toJSON cfg.config;
        };
      })
    ]
  );

}
