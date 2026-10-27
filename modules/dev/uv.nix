{
  config,
  lib,
  username,
  ...
}:
{
  options = {
    mods.uv = {
      enable = lib.mkEnableOption "Enables uv";
    };
  };
  config = lib.mkIf config.mods.uv.enable {
    home-manager.users.${username} = {
      programs.uv = {
        enable = true;
      };
    };
  };
}
