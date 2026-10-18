{
  config,
  lib,
  unstable-pkgs,
  username,
  ...
}:
let
  cfg = config.mods.claude;
in
{
  options = {
    mods.claude = {
      enable = lib.mkEnableOption "Enables Claude";
    };
    config = lib.mkIf cfg.enable { environment.systemPackages = [ unstable-pkgs.claude-code ]; };
  };
}
