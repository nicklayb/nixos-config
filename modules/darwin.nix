{ pkgs, ... }:
{
  imports = [
    ./dev/tools.nix
    ./command_line/tmux
    ./fonts/darwin.nix
    ./applications/vscode.nix
    ./applications/alacritty
    ./applications/zen
    ./desktop_environment/darwin_tiling
  ];
}
