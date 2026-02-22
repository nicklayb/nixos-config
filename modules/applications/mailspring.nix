{ config, lib, pkgs, ... }: {
  options = {
    mods.mailspring = {
      enable = lib.mkEnableOption "Enables Mailspring";
    };
  };
  config = lib.mkIf config.mods.mailspring.enable {
  environment.systemPackages = with pkgs; [
      (mailspring.overrideAttrs (oldAttrs: {
        postFixup = ''
          substituteInPlace $out/share/applications/Mailspring.desktop \
            --replace-fail Exec=mailspring "Exec=$out/bin/mailspring --password-store=gnome-libsecret"
        '';
      }))
    ];
  };
}
