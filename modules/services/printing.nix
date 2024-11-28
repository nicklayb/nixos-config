{ config, lib, pkgs, ... }: {
  options = {
    mods.printing = {
      enable = lib.mkEnableOption "Enables printing";
    };
  };
  config = lib.mkIf config.mods.printing.enable {
    services.printing.enable = true;
    services.printing.cups-pdf.enable = true;
    services.printing.webInterface = true;
    services.printing.drivers = [ pkgs.brlaser ];
    services.avahi.enable = true;
    services.avahi.nssmdns = true;
    services.avahi.openFirewall = true;
  };
}
