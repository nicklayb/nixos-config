{ config, lib, pkgs, ... }: {
  options = {
    mods._1password = {
      enable = lib.mkEnableOption "Enables 1Password";
    };
  };
  config = lib.mkIf config.mods._1password.enable {
    programs._1password.enable = true;
    programs._1password-gui.enable = true;
  };
}
