{ pkgs, ... }: {
  imports = [
    ./1password.nix
    ./alacritty
    ./firefox.nix
    ./nautilus.nix
    ./snap.nix
    ./steam.nix
    ./wallet.nix
  ];

  environment.systemPackages = with pkgs; [
    krita
    pavucontrol
    vlc
  ];
}
