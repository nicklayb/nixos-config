{
  config,
  pkgs,
  lib,
  username,
  ...
}:
let
  opn-api = pkgs.callPackage ./opn-api.nix { };

  # The default runtime shell is built without readline, which breaks prefilled prompts (`read -e -i`).
  interactiveBuilders = pkgs.callPackage "${pkgs.path}/pkgs/build-support/trivial-builders" {
    runtimeShell = lib.getExe pkgs.bashInteractive;
  };

  unbound-hosts = interactiveBuilders.writeShellApplication {
    name = "unbound-hosts";
    runtimeInputs = [
      opn-api
      pkgs.fzf
      pkgs.jq
      pkgs.util-linux
      pkgs.coreutils
    ];
    text = builtins.readFile ./unbound-hosts.sh;
  };
in
{
  options = {
    mods.opn-api = {
      enable = lib.mkEnableOption "Enables opn-api";
    };
  };

  config = lib.mkIf config.mods.opn-api.enable {
    environment.systemPackages = [
      opn-api
      unbound-hosts
    ];
  };
}
