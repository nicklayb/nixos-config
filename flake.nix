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
    musnix = { url = "github:musnix/musnix"; };
    nix-snapd = { url = "github:nix-community/nix-snapd"; };
  };

  outputs = { self, lib, nixpkgs, home-manager, ... }@inputs: let
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
    build-home = { username }@user: {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit pkgs stateVersion inputs; };
      home-manager.users.${username} = import ./homes/${username} { user = user; };
    };
    nboisvert = {
      username = "nboisvert";
      name = "Nicolas Boisvert";
      email = "nicklay@me.com";
      groups = [ "wheel" "docker" ];
    };
    elaforme = {
      username = "elaforme";
      name = "Eve-Lynn Laforme";
      groups = [];
    };
    build-system = { users, hostname } : nixpkgs.lib.nixosSystem {
      specialArgs = {
        hostname = hostname;
        inherit stateVersion pkgs self system inputs users mainUser;
      };
      inherit system;
      modules = lib.concat [
        [
          ./modules
          ./hosts/${hostname}/configuration.nix
          ./hosts/${hostname}/hardware-configuration.nix
          home-manager.nixosModules.home-manager
        ]
        (map build-home (builtins.attrValues users))
      ];
    };
  in {
    nixosConfigurations = {
      "destroyer" = build-system { hostname = "destroyer"; users = { inherit nboisvert; }; };
      "t480s" = build-system { hostname = "t480s"; users = { inherit nboisvert; }; };
      "fleur-de-lys" = build-system { hostname = "fleur-de-lys"; users = { inherit nboisvert; }; };
      "macmini" = build-system { hostname = "macmini"; users = { inherit nboisvert elaforme; }; };
      "macpro" = build-system { hostname = "macpro"; users = { inherit nboisvert; }; };
    };
  };
}
