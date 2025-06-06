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
    services.printing.drivers = [ 
      pkgs.brlaser
      pkgs.epson-escpr2
    ];
    services.avahi.enable = true;
    services.avahi.nssmdns4 = true;
    services.avahi.openFirewall = true;
  };
}
