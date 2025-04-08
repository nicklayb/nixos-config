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

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      mainUser = {
        username = "nboisvert";
        name = "Nicolas Boisvert";
        email = "nicklay@me.com";
      };
      options = {
        self = self;
        inputs = inputs;
        mainUser = mainUser;
      };
      build-nixos-system = import ./build_nixos.nix options;
      build-darwin-system = import ./build_darwin.nix options;
    in
    {
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
