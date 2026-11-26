{ config, lib, ... }: {
  options = {
    mods.inputs.immurok = {
      enable = lib.mkEnableOption "Enables immurok";
    };
  };
  config = lib.mkIf config.mods.inputs.immurok.enable {
    services.immurok = {
      enable = true;
      pam.services = [
        "sudo"
        "polkit-1"
      ];
    };
  };
}
