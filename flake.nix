{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    firefox-firefox-mod-blur = { url = "github:datguypiko/Firefox-Mod-Blur"; flake = false; };
    firefox-textfox = { url = "github:nicklayb/textfox"; flake = false; };
    astronvim-config = { url = "github:nicklayb/astronvim"; flake = false; };
    elixir-extensions = { url = "github:nicklayb/ex_tensions"; flake = false; };
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
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = inputs:
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
      };
      darwinConfigurations = {
        "WorkBookPro" = build-darwin-system "WorkBookPro" "nicolas.boisvert";
        "StudioMini" = build-darwin-system "StudioMini" "nboisvert";
      };
    };
}
