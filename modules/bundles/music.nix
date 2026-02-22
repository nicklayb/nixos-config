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
      defaultPackages = [
        pkgs.alsa-scarlett-gui
        pkgs.jack2
        pkgs.qjackctl
        pkgs.pavucontrol
        pkgs.libjack2
        pkgs.jack_capture
      ];
    in
    {
      musnix.enable = true;

      boot.kernelModules = [ "snd-seq" "snd-rawmidi" ];

      environment.systemPackages = defaultPackages ++ bitwig ++ reaper ++ ardour;

      services.pipewire.enable = true;
      services.pulseaudio.enable = false;

      services.jack = {
        jackd.enable = true;
        # support ALSA only programs via ALSA JACK PCM plugin
        alsa.enable = false;
        # support ALSA only programs via loopback device (supports programs like Steam)
        loopback = {
          enable = true;
        };
      };


      users.users.${username} = {
        extraGroups = [ "audio" "jackaudio" ];
      };
    }
  );
  imports = [
    inputs.musnix.nixosModules.musnix
  ];
}
