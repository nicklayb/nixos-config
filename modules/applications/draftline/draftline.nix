{
  lib,
  stdenv,
  fetchurl,
  appimageTools,
  version,
}:

let
  pname = "draftline";

  appimage = fetchurl {
    url = "https://github.com/DraftlineStudio/draftlinestudio/releases/download/${version}/Draftline-${version}-linux-x86_64.AppImage";
    hash = "sha256-KzMNrRTCQn9BZMMGvzdg4466nneHMQaZjTIpgfslrlM=";
  };

in
appimageTools.wrapType2 {
  inherit pname version;

  src = appimage;

  extraPkgs = pkgs: [
    pkgs.webkitgtk_4_1
    pkgs.libsoup_3
  ];

  extraInstallCommands = ''
    mkdir -p $out/share/applications

    cat > $out/share/applications/draftline.desktop <<EOF
    [Desktop Entry]
    Name=Draftline
    Comment=Writing application
    Exec=draftline
    Type=Application
    Terminal=false
    Categories=Office;WordProcessor;
    EOF
  '';

  meta = {
    description = "Draftline writing application";
    homepage = "https://draftline.ink/";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    mainProgram = "draftline";
  };
}
