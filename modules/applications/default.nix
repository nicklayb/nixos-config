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
    ./zen.nix
  ];

  environment.systemPackages = with pkgs; [
    krita
    obsidian
    pavucontrol
    vlc
    gparted
    plexamp
    localsend
    libreoffice
  ];

  networking.firewall = {
    allowedTCPPorts = [ localsendPort ];
  };
}
