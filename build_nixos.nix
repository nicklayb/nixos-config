{ mainUser, inputs }:
let
  system = "x86_64-linux";
  stateVersion = "24.11";
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
    config.nvidia.acceptLicense = true;
    overlays = [
      inputs.nix-vscode-extensions.overlays.default
    ];
    config.permittedInsecurePackages = [
      "broadcom-sta-6.30.223.271-59-6.12.66"
    ];
  };
  unstable-pkgs = import inputs.nixpkgs-unstable {
    inherit system;
    overlays = [
      inputs.nix-vscode-extensions.overlays.default
    ];
  };
  utils = import ./utils.nix { };
  nixos-home-config = username: {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.nboisvert = import ./homes/nboisvert/nixos.nix;
    home-manager.extraSpecialArgs = {
      inherit
        pkgs
        username
        mainUser
        stateVersion
        inputs
        utils
        ;
    };
  };
  self = inputs.self;
in
hostname: username:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {
    hostname = hostname;
    inherit
      stateVersion
      pkgs
      self
      system
      inputs
      mainUser
      username
      unstable-pkgs
      utils
      ;
  };

  inherit system;
  modules = [
    ./modules
    ./hosts/${hostname}/configuration.nix
    ./hosts/${hostname}/hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.catppuccin.nixosModules.catppuccin
    (nixos-home-config username)
  ];
}
