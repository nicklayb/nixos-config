{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-firefox-mod-blur = { url = "github:datguypiko/Firefox-Mod-Blur"; flake = false; };
    firefox-textfox = { url = "github:nicklayb/textfox"; flake = false; };
    astronvim-config = { url = "github:nicklayb/astronvim"; flake = false; };
    musnix.url = "github:musnix/musnix";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser = {
      # Locking to 1.6b
      url = "github:omarcresp/zen-browser-flake/e51913e312a92e47fe90cc3381202b6c9bcaa1ec";
    };
    nixos-06cb-009a-fingerprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor?ref=24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    system = "x86_64-linux";
    stateVersion = "24.11";
    mainUser = {
      username = "nboisvert";
      name = "Nicolas Boisvert";
      email = "nicklay@me.com";
    };
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
    build-nixos-system = hostname : nixpkgs.lib.nixosSystem {
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
    };
    build-darwin-system = hostname : inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {
        system = "aarch64-darwin";
        inherit unstable-pkgs;
      };
      modules = [
        ./hosts/${hostname}/configuration.nix
        ./modules/darwin.nix
      ];
    };
  in {
    nixosConfigurations = {
      "destroyer" = build-nixos-system "destroyer";
      "t480s" = build-nixos-system "t480s";
      "drumboi" = build-nixos-system "drumboi";
      "fleur-de-lys" = build-nixos-system "fleur-de-lys";
      "macmini" = build-nixos-system "macmini";
      "imac" = build-nixos-system "imac";
      "macpro" = build-nixos-system "macpro";
    };
    darwinConfigurations = {
      "WorkBookPro" = build-darwin-system "WorkBookPro";
      "StudioMini" = build-darwin-system "StudioMini";
    };
  };
}
