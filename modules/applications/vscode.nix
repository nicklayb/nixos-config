{ config, lib, username, pkgs, ... }: {
  options = {
    mods.vscode = {
      enable = lib.mkEnableOption "Enables vscode";
      cycode = lib.mkEnableOption "Enables Cycode extension";
    };
  };
  config = lib.mkIf config.mods.vscode.enable {
    home-manager.users."${username}".programs.vscode = {
      enable = true;

      userSettings = {
        "editor.lineNumbers" = "relative";
      };

      extensions = with pkgs.vscode-marketplace; [
        vscodevim.vim

        # AI
        github.copilot

        # Elixir stuff
        jakebecker.elixir-ls
        pantajoe.vscode-elixir-credo
      ] ++ (if config.mods.vscode.cycode then
        [
          cycode.cycode
        ] else
        [ ]
      );
    };
  };
}
