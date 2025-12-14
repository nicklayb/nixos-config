{ config, lib, pkgs, ... }: {
  options = {
    mods.sddm = {
      enable = lib.mkEnableOption "Enables SDDM";
      settings = lib.mkOption {
        description = "Settings for SDDM";
        type = lib.types.attrs;
        default = {};
      };
    };
  };
  config = lib.mkIf config.mods.sddm.enable {
    services.displayManager.sddm = {
      enable = true;
      extraPackages = [
        pkgs.sddm-astronaut
      ];
      theme = "sddm-astronaut-theme";
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      settings = config.mods.sddm.settings // { Theme = { Current = "sddm-astronaut-theme"; }; };
    };
    environment.systemPackages = [
      pkgs.sddm-astronaut
    ];
  };
}
