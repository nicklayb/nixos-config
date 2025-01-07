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
    environment.etc."1password/custom_allowed_browsers" = {
      text = ''
        .zen-wrapped
      '';
      mode = "0755";
    };
  };
}
