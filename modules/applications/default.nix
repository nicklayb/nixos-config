{ pkgs, ... }: {
  imports = [
    ./1password.nix
    ./alacritty
    ./firefox.nix
    ./nautilus.nix
    ./steam.nix
    ./wallet.nix
  ];

  environment.systemPackages = with pkgs; [
    krita
    mailspring
    pavucontrol
    vlc
    plexamp
  ];
}
