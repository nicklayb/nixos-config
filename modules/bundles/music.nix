{ config, lib, inputs, pkgs, username, ... }: {
  options = {
    bundles.music = {
      enable = lib.mkEnableOption "Enables Music bundle";
      bitwig = lib.mkOption {
        description = "Includes Bitwig Studio";
        default = true;
        type = lib.types.bool;
      };
      reaper = lib.mkOption {
        description = "Includes Reaper";
        default = true;
        type = lib.types.bool;
      };
      ardour = lib.mkOption {
        description = "Includes Ardour";
        default = true;
        type = lib.types.bool;
      };
    };
  };
  config = lib.mkIf config.bundles.music.enable (
    let
      packageIf = isTrue: whenTrue:
        if isTrue then
          whenTrue pkgs
        else
          [ ];
      bitwig = packageIf config.bundles.music.bitwig (packages: [packages.bitwig-studio]);
      reaper = packageIf config.bundles.music.reaper (packages: [packages.reaper]);
      ardour = packageIf config.bundles.music.ardour (packages: [packages.ardour]);
      defaultPackages = [pkgs.alsa-scarlett-gui];
    in
    {
      musnix.enable = true;

      environment.systemPackages = defaultPackages ++ bitwig ++ reaper ++ ardour;

      users.users.${username} = {
        extraGroups = [ "audio" ];
      };
    }
  );
  imports = [
    inputs.musnix.nixosModules.musnix
  ];
}
