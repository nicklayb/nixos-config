{ pkgs, ... }: {
  imports = [
    ./dev/tools.nix
    ./command_line/tmux
    ./fonts/darwin.nix
    ./applications/vscode.nix
    ./applications/zen
  ];
}
