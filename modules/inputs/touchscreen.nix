{ config, lib, pkgs, username, ... }: {
  options = {
    mods.inputs.touchscreen = {
      enable = lib.mkEnableOption "Enables touchscreen";
    };
  };
  config = lib.mkIf config.mods.inputs.touchscreen.enable {
    environment.systemPackages = [
      pkgs.wvkbd
    ];


    home-manager.users.${username} = {
      xdg.configFile = {
        "touchscreen/toggle.sh".source = ./toggle.sh;
      };
    };
  };
}
