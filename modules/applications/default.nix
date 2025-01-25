{ pkgs, ... }: {
  imports = [
    ./1password.nix
    ./alacritty
    ./ardour.nix
    ./dbeaver.nix
    ./firefox.nix
    ./insomnia.nix
    ./heroic.nix
    ./nautilus.nix
    ./reaper.nix
    ./steam.nix
    ./wallet.nix
    ./zen.nix
  ];

  environment.systemPackages = with pkgs; [
    krita
    mailspring
    obsidian
    pavucontrol
    vlc
    gparted
    plexamp
    localsend
    wpsoffice
  ];
}
