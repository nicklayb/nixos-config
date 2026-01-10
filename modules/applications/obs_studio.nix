{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    mods.obs_studio = {
      enable = lib.mkEnableOption "Enables OBS Studio";
      gpu = lib.mkOption {
        type = lib.types.enum [
          "nvidia"
          "intel"
          "amd"
        ];
        default = "intel";
        description = "Sets graphical drivers";
      };
    };
  };
  config =
    let
      isNvidia = config.mods.obs_studio.gpu == "nvidia";
    in
    lib.mkIf config.mods.obs_studio.enable {
      programs.obs-studio = {
        enable = true;

        package = (
          pkgs.obs-studio.override {
            cudaSupport = isNvidia;
          }
        );

        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
          obs-vaapi
          obs-gstreamer
          obs-vkcapture
        ];
      };
    };
}
