pkgs: with pkgs; [
  noto-fonts
  noto-fonts-cjk-sans
  noto-fonts-emoji
  font-awesome
  (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
]
