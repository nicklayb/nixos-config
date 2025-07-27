{ config, lib, pkgs, username, ... }: {
  options = {
    mods.wofi = {
      enable = lib.mkEnableOption "Enables Wofi";
    };
  };
  config = lib.mkIf config.mods.wofi.enable {

    environment.systemPackages = [
      pkgs.wofi
    ];

    home-manager.users.${username} = {
      programs.wofi = {
        enable = true;
        style = lib.readFile ./style.css;
      };

      xdg.configFile."wofi/config".source = ./config;
    };
  };
}
