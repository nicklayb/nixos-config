let
  flake = builtins.getFlake (toString ./.);
  lib = flake.inputs.nixpkgs.lib;
  utils = import ./utils.nix { };
in
{
  flake = flake;
  utils = utils;
  lib = lib;
}
