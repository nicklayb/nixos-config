{ config, lib, pkgs, ... }: {
  options = {
    mods.hyprland = {
      enable = lib.mkEnableOption "Enables Hyprland";
    };
  };
  config = lib.mkIf config.mods.hyprland.enable {
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.theme = "sugar-candy";
    services.displayManager.sddm.wayland.enable = true;
    programs.hyprland.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    };

    environment.systemPackages = [
      pkgs.hyprpaper
      pkgs.hyprlock
      pkgs.hypridle
      pkgs.wofi
      pkgs.waybar
      (pkgs.callPackage ./sugar_candy.nix { }).sddm-sugar-candy-theme
      pkgs.libsForQt5.qt5.qtgraphicaleffects
    ];
  };
}
