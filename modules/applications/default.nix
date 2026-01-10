{ pkgs, ... }:
let
  localsendPort = 53317;
in
{
  imports = [
    ./1password.nix
    ./alacritty
    ./ardour.nix
    ./blender.nix
    ./dbeaver.nix
    ./deluge.nix
    ./matrix.nix
    ./firefox.nix
    ./github.nix
    ./heroic.nix
    ./insomnia.nix
    ./mailspring.nix
    ./nautilus.nix
    ./obs_studio.nix
    ./playstation.nix
    ./reaper.nix
    ./steam.nix
    ./thunderbird.nix
    ./vscode.nix
    ./wallet.nix
    ./zed.nix
    ./zen
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
