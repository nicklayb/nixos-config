{ pkgs, ... }: {
  imports = [
    ./flatpak.nix
  ];

  environment.systemPackages = with pkgs; [
    clang
    cargo
    python3
    jdk
  ];
}
