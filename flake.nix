{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-firefox-mod-blur = { url = "github:datguypiko/Firefox-Mod-Blur"; flake = false; };
    firefox-textfox = { url = "github:nicklayb/textfox"; flake = false; };
    astronvim-config = { url = "github:nicklayb/astronvim"; flake = false; };
    musnix = { url = "github:musnix/musnix"; };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    system = "x86_64-linux";
    stateVersion = "23.05";
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
    home-config = {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.nboisvert = import ./homes/nboisvert;
      home-manager.extraSpecialArgs = { inherit pkgs mainUser stateVersion inputs; };
    };
    build-system = hostname : nixpkgs.lib.nixosSystem {
      specialArgs = {
        hostname = hostname;
        inherit stateVersion pkgs self system inputs mainUser;
      };
      inherit system;
      modules = [
        ./modules
        ./hosts/${hostname}/configuration.nix
        ./hosts/${hostname}/hardware-configuration.nix
        home-manager.nixosModules.home-manager
        home-config
      ];
    };
  in {
    nixosConfigurations = {
      "destroyer" = build-system "destroyer";
      "t480s" = build-system "t480s";
      "fleur-de-lys" = build-system "fleur-de-lys";
      "macmini" = build-system "macmini";
      "macpro" = build-system "macpro";
    };
  };
}
