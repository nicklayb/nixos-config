{ ... }:
{
  imports = [
    ./dev/tools.nix
    ./command_line/tmux
    ./command_line/shells
    ./command_line/mise.nix
    ./fonts/darwin.nix
    ./applications/vscode.nix
    ./applications/alacritty
    ./applications/zen
    ./desktop_environment/darwin_tiling
    ./dev/linux_builder.nix
    ./services/local_llm.nix
    ./virtualization/colima
  ];
}
