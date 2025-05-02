{ pkgs, ... }: {
  imports = [
    ./command_line/tmux
  ];

  fonts = {
    packages = import ./fonts/packages.nix pkgs;
  };
}
