{ pkgs, ... }: {
  imports = [
    ./command_line/tmux
    ./applications/vscode.nix
  ];

  fonts = {
    packages = import ./fonts/packages.nix pkgs;
  };
}
