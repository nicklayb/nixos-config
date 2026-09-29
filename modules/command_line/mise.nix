{
  config,
  username,
  lib,
  ...
}:
{
  options = {
    mods.mise = {
      enable = lib.mkEnableOption "Enables Mise";
    };
  };

  config = lib.mkIf config.mods.mise.enable {
    home-manager.users.${username}.programs.mise = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
