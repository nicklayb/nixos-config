{ config, lib, pkgs, ... }: {
  options = {
    mods.touchpad = {
      enable = lib.mkEnableOption "Enables touchpad";
    };
  };
  config = lib.mkIf config.mods.touchpad.enable {
    services.libinput = {
      enable = true;
      touchpad.disableWhileTyping = false;
    };
  };
}
