{ config, lib, pkgs, ... }: {
  options = {
    mods.blender = {
      enable = lib.mkEnableOption "Enables Blender";
    };
  };
  config = lib.mkIf config.mods.blender.enable {
    environment.systemPackages = [
      pkgs.blender
    ];
  };
}
