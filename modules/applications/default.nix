{ pkgs, mainUser, inputs, ... }: {
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
    neovim
    pavucontrol
    vlc
  ];
}
