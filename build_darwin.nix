{ inputs, mainUser, ... }:
let
  system = "aarch64-darwin";
  stateVersion = "24.11";
  pkgs = import inputs.nixpkgs {
    inherit system;
    overlays = [
      inputs.nix-vscode-extensions.overlays.default
    ];
    config = { allowUnfree = true; };
  };
  unstable-pkgs = import inputs.nixpkgs-unstable {
    inherit system;
  };
  darwin-home-config = username: {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.${username} = import ./homes/nboisvert/darwin.nix;
    home-manager.extraSpecialArgs = { inherit pkgs username mainUser stateVersion inputs; };
    home-manager.backupFileExtension = "hm.bak";
  };
in
hostname: username: inputs.nix-darwin.lib.darwinSystem {
  specialArgs = {
    system = "aarch64-darwin";
    inherit pkgs unstable-pkgs mainUser username;
  };
  modules = [
    ./hosts/${hostname}/configuration.nix
    ./modules/darwin.nix
    inputs.home-manager.darwinModules.home-manager
    (darwin-home-config username)
  ];
}
