{ config, lib, pkgs, mainUser, ... }: {
  options = {
    mods.waybar = {
      enable = lib.mkEnableOption "Enables Waybar";
    };
  };
  config = lib.mkIf config.mods.waybar.enable {

    environment.systemPackages = [
      pkgs.waybar
    ];

    home-manager.users.${mainUser.username} = {
      programs.waybar = {
        enable = true;
        style = ./style.css;
        systemd.enable = true;
      };
      xdg.configFile."waybar/config".source = ./config.json;
      xdg.configFile."waybar/mocha.css".source = ./mocha.css;
      xdg.configFile."waybar/nixos.svg".source = ./nixos.svg;
    };
  };
}
