{ pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      font-awesome
      (nerdfonts.override { fonts = ["CascadiaCode"]; })
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["CaskaydiaCove Nerd Font Mono"];
        serif = ["Noto Serif" "Source Han Serif"];
        sansSerif = ["Noto Sans" "Source Han Sans"];
      };
    };
  };
}
