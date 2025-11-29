{ config, lib, pkgs, ... }: let
  vrPorts = [ 10400 10401 ];
in {
  options = {
    mods.steam = {
      enable = lib.mkEnableOption "Enables Steam";
    };
  };
  config = lib.mkIf config.mods.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
    };
    environment.systemPackages = [
      pkgs.xwayland
      pkgs.usbutils
    ];
    programs.gamemode.enable = true;
    networking.firewall.allowedUDPPorts = vrPorts;
  };
}
