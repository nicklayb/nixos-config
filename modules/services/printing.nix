{ config, lib, pkgs, ... }: let
  brother = {
    name = "Brother";
    ip = "192.168.1.91";
  };
  epson = {
    name = "Epson";
    ip = "192.168.1.97";
  };
in {
  options = {
    mods.printing = {
      enable = lib.mkEnableOption "Enables printing";
    };
  };
  config = lib.mkIf config.mods.printing.enable {
    hardware.printers = {
      ensureDefaultPrinter = brother.name;
      ensurePrinters = [
        {
          description = "Brother HL-2370DW";
          name = brother.name;
          deviceUri = "ipp://${brother.ip}/ipp";
          model = "drv:///brlaser.drv/brl2370d.ppd";
        }
        {
          description = "Epson ET-8500";
          name = epson.name;
          deviceUri = "ipp://${epson.ip}/ipp";
          model = "epson-inkjet-printer-escpr2/Epson-ET-8500_Series-epson-escpr2-en.ppd";
        }
      ];
    };
    services.printing = {
      enable = true;
      cups-pdf.enable = true;
      webInterface = true;
      drivers = [ 
        # Brother
        pkgs.brlaser
        # Epson
        pkgs.epson-escpr2
      ];
    };
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
