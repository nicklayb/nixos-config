{ pkgs, ... }: {
  fonts = {
    packages = import ./packages pkgs;
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "CaskaydiaCove Nerd Font Mono" ];
        serif = [ "Noto Serif" "Source Han Serif" ];
        sansSerif = [ "Noto Sans" "Source Han Sans" ];
      };
    };
  };
}
