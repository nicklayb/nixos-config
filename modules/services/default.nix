{ ... }: {
  imports = [
    ./networking.nix
    ./node-exporter.nix
    ./printing.nix
  ];
}
