{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    homeConfigurations = {
      "nboisvert" = home-manager.lib.homeManagerConfiguration {
        specialArgs = {
          inherit pkgs mainUser;
        };
        modules = [
         ./homes/nboisvert.nix
        ];
      };
    };
    nixosConfigurations = {
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
        ];
      };
    };
  };
}
