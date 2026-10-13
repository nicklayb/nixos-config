{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    mods.draftline = {
      enable = lib.mkEnableOption "Enables Draftline";

      version = lib.mkOption {
        type = lib.types.str;
        default = "1.0.02743";
        description = "Version of the package";
      };
    };
  };
  config = lib.mkIf config.mods.draftline.enable {
    environment.systemPackages = [
      (pkgs.callPackage ./draftline.nix { version = config.mods.draftline.version; })
    ];
  };
}
