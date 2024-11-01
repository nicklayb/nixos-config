{ pkgs, ... }: {
  imports = [
    ./1password.nix
    ./alacritty
    ./ardour.nix
    ./firefox.nix
    ./nautilus.nix
    ./steam.nix
    ./wallet.nix
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
