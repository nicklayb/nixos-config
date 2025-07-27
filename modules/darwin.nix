{ pkgs, ... }: {
  imports = [
    ./command_line/tmux
    ./fonts/darwin.nix
    ./applications/vscode.nix
  ];
}
