{ config, lib, pkgs, mainUser, username, ... }: {
  options = {
    mods.fonts = {
      enable = lib.mkEnableOption "Enables Fonts";
    };
  };
  config = lib.mkIf config.mods.fonts.enable {
    fonts = {
      packages = import ./packages.nix pkgs;
    };
  };
}
