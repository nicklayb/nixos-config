{ config, lib, pkgs, username, ... }: {
  options = {
    mods.waybar = {
      enable = lib.mkEnableOption "Enables Waybar";
      theme = lib.mkOption {
        description = "Theme to apply";
        default = "pastel";
        type = lib.types.str;
      };
    };
  };
  config = lib.mkIf config.mods.waybar.enable {

    environment.systemPackages = [
      pkgs.waybar
    ];

    home-manager.users.${username} = {
      programs.waybar = {
        enable = true;
        style = ./${config.mods.waybar.theme}.css;
      };
      xdg.configFile."waybar/config".source = ./config.json;
      xdg.configFile."waybar/mocha.css".source = ./mocha.css;
      xdg.configFile."waybar/nixos.svg".source = ./nixos.svg;
    };
  };
}
