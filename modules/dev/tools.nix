{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    clang
    cargo
    python3
    jdk
    nil
    lua-language-server
  ];
}
