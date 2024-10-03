{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-mod-blur = { url = "github:datguypiko/Firefox-Mod-Blur"; flake = false; };
    astronvim-config = { url = "github:nicklayb/astronvim"; flake = false; };
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
    };
  in {
    nixosConfigurations = {
      "destroyer" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          hostname = "destroyer";
          inherit stateVersion pkgs self system inputs mainUser;
        };
        inherit system;
        modules = [
           ./modules
          ./hosts/destroyer/configuration.nix
          ./hosts/destroyer/hardware-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nboisvert = import ./homes/nboisvert;
            home-manager.extraSpecialArgs = { inherit pkgs mainUser stateVersion inputs; };
          }
        ];
      };
      "t480s" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          hostname = "t480s";
          inherit stateVersion pkgs self system inputs mainUser;
        };
        inherit system;
        modules = [
           ./modules
          ./hosts/t480s/configuration.nix
          ./hosts/t480s/hardware-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nboisvert = import ./homes/nboisvert;
            home-manager.extraSpecialArgs = { inherit pkgs mainUser stateVersion inputs; };
          }
        ];
      };
      "fleur-de-lys" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          hostname = "fleur-de-lys";
          inherit stateVersion pkgs self system inputs mainUser;
        };
        inherit system;
        modules = [
           ./modules
          ./hosts/fleur-de-lys/configuration.nix
          ./hosts/fleur-de-lys/hardware-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nboisvert = import ./homes/nboisvert;
            home-manager.extraSpecialArgs = { inherit pkgs mainUser stateVersion inputs; };
          }
        ];
      };
    };
  };
}
