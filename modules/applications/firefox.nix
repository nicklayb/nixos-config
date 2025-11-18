{ config, lib, mainUser, username, pkgs, inputs, ... }: {
  options = {
    mods.firefox = {
      enable = lib.mkEnableOption "Enables Firefox";
      theme = lib.mkOption {
        description = "Theme to apply";
        default = "textfox";
        type = lib.types.str;
      };
    };
  };
  config = lib.mkIf config.mods.firefox.enable {
    environment.systemPackages = [
      pkgs.firefox
    ];

    home-manager.users.${username} = {
      programs.firefox = {
        enable = true;
      };
    };
  };
}
