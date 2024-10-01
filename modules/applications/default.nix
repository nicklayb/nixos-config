{ pkgs, ... }: {
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    firefox
    neovim
    krita
    pavucontrol
    vlc
    alacritty
  ];
}
