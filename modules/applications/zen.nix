{ config, lib, inputs, system, ... }: {
  options = {
    mods.zen = {
      enable = lib.mkEnableOption "Enables Zen Browser";
    };
  };
  config = lib.mkIf config.mods.zen.enable {
    environment.systemPackages = [
      inputs.zen-browser.packages."${system}".specific
    ];
  };
}
