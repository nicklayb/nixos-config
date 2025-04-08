{ inputs, ... }:
let
  system = "aarch64-darwin";
  unstable-pkgs = import inputs.nixpkgs-unstable {
    inherit system;
  };
in
hostname: inputs.nix-darwin.lib.darwinSystem {
  specialArgs = {
    system = "aarch64-darwin";
    inherit unstable-pkgs;
  };
  modules = [
    ./hosts/${hostname}/configuration.nix
    ./modules/darwin.nix
  ];
}
