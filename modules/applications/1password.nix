{ config, lib, username, pkgs, ... }: {
  options = {
    mods._1password = {
      enable = lib.mkEnableOption "Enables 1Password";
    };
  };
  config = lib.mkIf config.mods._1password.enable {
    environment.systemPackages = [
      pkgs._1password-cli
      pkgs._1password-gui
    ];
    programs._1password.enable = true;
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "${username}" ];
    };
  };
}
