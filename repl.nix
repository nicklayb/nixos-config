let
  flake = builtins.getFlake (toString ./.);
  lib = flake.inputs.nixpkgs.lib;
  box = import ./box.nix { };
in
{
  flake = flake;
  box = box;
  lib = lib;
}
