{ pkgs, ... }: {
  fonts = {
    packages = import ./packages.nix pkgs;
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
