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

  meta = {
    description = "Draftline writing application";
    homepage = "https://draftline.ink/";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    mainProgram = "draftline";
  };
}
