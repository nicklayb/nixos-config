{
  lib,
  buildRubyGem,
  ruby,
}:

buildRubyGem rec {
  inherit ruby;
  pname = "opn-api";
  gemName = "opn_api";
  version = "1.1.0";
  source.sha256 = "91f57ca442fe51b37a7dc8ed7a7a7e174b3ffba02a37f61b8a491e51825d83f5";

  meta = {
    description = "Command line client and Ruby library for the OPNsense API";
    homepage = "https://github.com/markt-de/opn-api";
    license = lib.licenses.bsd2;
    mainProgram = "opn-api";
  };
}
