{ config, lib, pkgs, ... }: {
  options = {
    mods.networking = {
      enable = lib.mkEnableOption "Enables Networking";
      hostname = lib.mkOption {
        description = "Hostname";
        type = lib.types.str;
      };
      networkManager = lib.mkOption {
        description = "Enables NetworkManager";
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf config.mods.networking.enable {
    networking.hostName = config.mods.networking.hostname;
    networking.networkmanager.enable = config.mods.networking.networkManager;
    networking.useDHCP = lib.mkDefault true;

    environment.systemPackages = [
      pkgs.inetutils
    ];
  };
}
