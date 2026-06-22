{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-25-11.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    astronvim-config = {
      url = "github:nicklayb/astronvim/v5";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    elixir-extensions = {
      url = "github:nicklayb/ex_tensions";
      flake = false;
    };
    musnix.url = "github:musnix/musnix";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.home-manager.follows = "home-manager";
    };
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    plexm3u.url = "github:nicklayb/plexm3u";
    squix = {
      url = "github:eduardofuncao/squix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    recording-monitor = {
      url = "github:nicklayb/recording-monitor";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      mainUser = {
        githubUsername = "nicklayb";
        name = "Nicolas Boisvert";
        email = "nicklay@me.com";
      };
      options = {
        inputs = inputs;
        mainUser = mainUser;
      };
      build-nixos-system = import ./build_nixos.nix options;
      build-darwin-system = import ./build_darwin.nix options;
    in
    {
      nixosConfigurations = {
        "destroyer" = build-nixos-system "destroyer" "nboisvert";
        "t480s" = build-nixos-system "t480s" "nboisvert";
        "drumboi" = build-nixos-system "drumboi" "nboisvert";
        "fleur-de-lys" = build-nixos-system "fleur-de-lys" "nboisvert";
        "macmini" = build-nixos-system "macmini" "nboisvert";
        "imac" = build-nixos-system "imac" "nboisvert";
        "macpro" = build-nixos-system "macpro" "nboisvert";
        "garage" = build-nixos-system "garage" "nboisvert";
      };
      darwinConfigurations = {
        "WorkBookPro" = build-darwin-system "WorkBookPro" "nicolas.boisvert";
        "StudioMini" = build-darwin-system "StudioMini" "nboisvert";
      };
      nixosModules = {
        nicklayb = import ./modules;
      };
    };
}
