{ pkgs, ... }:
let
  localsendPort = 53317;
in
{
  imports = [
    ./1password.nix
    ./alacritty
    ./ardour.nix
    ./dbeaver.nix
    ./deluge.nix
    ./firefox.nix
    ./github.nix
    ./insomnia.nix
    ./heroic.nix
    ./mailspring.nix
    ./nautilus.nix
    ./playstation.nix
    ./reaper.nix
    ./steam.nix
    ./vscode.nix
    ./wallet.nix
    ./zed.nix
    ./zen.nix
  ];

  environment.systemPackages = with pkgs; [
    xfce.ristretto
    obsidian
    pavucontrol
    vlc
    gparted
    exfatprogs
    plexamp
    localsend
    libreoffice
  ];

  networking.firewall = {
    allowedTCPPorts = [ localsendPort ];
  };
}
