{ mainUser, inputs }:
let
  system = "x86_64-linux";
  stateVersion = "24.11";
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
    config.nvidia.acceptLicense = true;
  };
  unstable-pkgs = import inputs.nixpkgs-unstable {
    inherit system;
  };
  nixos-home-config = {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.nboisvert = import ./homes/nboisvert;
    home-manager.extraSpecialArgs = { inherit pkgs mainUser stateVersion inputs; };
  };
in
hostname: nixpkgs.lib.nixosSystem {
  specialArgs = {
    hostname = hostname;
    inherit stateVersion pkgs self system inputs mainUser unstable-pkgs;
  };
  inherit system;
  modules = [
    ./modules
    ./hosts/${hostname}/configuration.nix
    ./hosts/${hostname}/hardware-configuration.nix
    home-manager.nixosModules.home-manager
    nixos-home-config
  ];
}
