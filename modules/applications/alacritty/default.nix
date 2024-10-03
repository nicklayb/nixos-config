{ config, lib, mainUser, pkgs, ... }: {
  options = {
    mods.alacritty = {
      enable = lib.mkEnableOption "Enables Alacritty";
    };
  };
  config = lib.mkIf config.mods.alacritty.enable {
    environment.systemPackages = [
      pkgs.alacritty
    ];
    
    home-manager.users.${mainUser.username} = {
      programs.alacritty = {
        enable = true;
        settings = lib.importTOML ./alacritty.toml;
      };
    };
  };
}
