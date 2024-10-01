{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    clang
    cargo
    python3
  ];
}
