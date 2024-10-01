{ config, lib, ... }: {
  options = {
    mods.inputs.touchpad = {
      enable = lib.mkEnableOption "Enables touchpad";
    };
  };
  config = lib.mkIf config.mods.inputs.touchpad.enable {
    services.libinput = {
      enable = true;
      touchpad.disableWhileTyping = false;
    };
  };
}
