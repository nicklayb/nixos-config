{ inputs, mainUser, ... }:
let
  system = "aarch64-darwin";
  stateVersion = "24.11";
  pkgs = import inputs.nixpkgs {
    inherit system;
    overlays = [
      inputs.nix-vscode-extensions.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
    config.permittedInsecurePackages = [
      "lima-full-1.2.2"
      "lima-additional-guestagents-1.2.2"
    ];
  };
  unstable-pkgs = import inputs.nixpkgs-unstable {
    inherit system;
  };
  box = import ./box.nix { };
  darwin-home-config = username: {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.${username} = import ./homes/nboisvert/darwin.nix;
    home-manager.extraSpecialArgs = {
      inherit
        pkgs
        username
        mainUser
        stateVersion
        inputs
        box
        ;
    };
    home-manager.backupFileExtension = "hm.bak";
  };
in
hostname: username:
inputs.nix-darwin.lib.darwinSystem {
  specialArgs = {
    system = "aarch64-darwin";
    inherit
      pkgs
      unstable-pkgs
      mainUser
      username
      box
      inputs
      ;
  };

  modules = [
    ./hosts/${hostname}/configuration.nix
    ./modules/darwin.nix
    inputs.home-manager.darwinModules.home-manager
    (darwin-home-config username)
  ];
}
