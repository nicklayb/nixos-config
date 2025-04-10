{ inputs, ... }:
let
  system = "aarch64-darwin";
  stateVersion = "24.11";
  pkgs = import inputs.nixpkgs {
    inherit system;
  };
  unstable-pkgs = import inputs.nixpkgs-unstable {
    inherit system;
  };
  darwin-home-config = username: {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.${username} = import ./homes/nboisvert/darwin.nix;
    home-manager.extraSpecialArgs = { inherit pkgs username stateVersion inputs; };
  };
in
hostname: username: inputs.nix-darwin.lib.darwinSystem {
  specialArgs = {
    system = "aarch64-darwin";
    inherit unstable-pkgs username;
  };
  modules = [
    ./hosts/${hostname}/configuration.nix
    ./modules/darwin.nix
    inputs.home-manager.darwinModules.home-manager
    (darwin-home-config username)
  ];
}
