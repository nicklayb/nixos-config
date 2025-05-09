{ config, lib, mainUser, pkgs, ... }: {
  options = {
    mods.github = {
      enable = lib.mkEnableOption "Enables GitHub";
    };
  };
  config = lib.mkIf config.mods.github.enable {
    environment.systemPackages = [
      pkgs.gh
    ];
  };
}
