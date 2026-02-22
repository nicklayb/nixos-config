{ config, lib, mainUser, pkgs, ... }: {
  options = {
    mods.matrix = {
      enable = lib.mkEnableOption "Enables Matrix client";
      client = lib.mkOption {
        description = "Client to use";
        type = lib.types.enum [ "fractal" ];
        default = "fractal";
      };
    };
  };
  config = lib.mkIf config.mods.matrix.enable {
    environment.systemPackages =
      if config.mods.matrix.client == "fractal" then
        [ pkgs.fractal ]
      else
        [];
  };
}
