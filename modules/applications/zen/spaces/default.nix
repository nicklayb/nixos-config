{ lib, box, ... }:
let
  builder = import ./builder.nix {
    lib = lib;
    utils = box;
  };
  args = {
    builder = builder;
  };

  personal = import ./personal.nix args;
  shopping = import ./shopping.nix args;
  dev = import ./dev.nix args;
  work = import ./work.nix args;

  all = [
    personal
    shopping
    dev
    work
  ];
in
{
  containers = builder.toContainers all;
  spaces = builder.toSpaces all;
  pins = builder.toPins all;
}
