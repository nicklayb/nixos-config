{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    (mailspring.overrideAttrs (oldAttrs: {
      postFixup = ''
        substituteInPlace $out/share/applications/Mailspring.desktop \
          --replace-fail Exec=mailspring "Exec=$out/bin/mailspring --password-store=gnome-libsecret"
      '';
    }))
  ];}
