{ config, lib, pkgs, mainUser, ... }: {
  options = {
    mods.wofi = {
      enable = lib.mkEnableOption "Enables Wofi";
    };
  };
  config = lib.mkIf config.mods.wofi.enable {

    environment.systemPackages = [
      pkgs.wofi
    ];

    home-manager.users.${mainUser.username} = {
      programs.wofi = {
        enable = true;
        settings = import ./config.nix;
        style = lib.readFile ./style.css;
      };
    };
  };
}
