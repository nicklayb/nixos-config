{ config, lib, username, pkgs, ... }: {
  options = {
    mods.vscode = {
      enable = lib.mkEnableOption "Enables vscode";
      cycode = lib.mkEnableOption "Enables Cycode extension";
    };
  };
  config = lib.mkIf config.mods.vscode.enable {
    home-manager.users."${username}".programs.vscode.profiles.default =
      let
        extensionsIf = isTrue: whenTrue:
          if isTrue then
            whenTrue pkgs.vscode-marketplace
          else
            [ ];

        default_extensions = with pkgs.vscode-marketplace; [
          vscodevim.vim

          # AI
          github.copilot

          # Elixir stuff
          jakebecker.elixir-ls
          pantajoe.vscode-elixir-credo
        ];

        cycode_extensions = extensionsIf config.mods.vscode.cycode (extensions:
          [
            extensions.cycode.cycode
          ]);
      in
      {
        enable = true;

        userSettings = {
          "editor.lineNumbers" = "relative";
          "workbench.settings.editor" = "json";
          "vim.leader" = "<space>";
          "vim.normalModeKeyBindings" = [
            {
              "before" = [ "<leader>" "c" ];
              "commands" = [
                "workbench.action.closeActiveEditor"
              ];
            }
            {
              "before" = [ "<leader>" "f" "f" ];
              "commands" = [
                "search.findInFiles"
              ];
            }
          ];
        };

        extensions = default_extensions ++ cycode_extensions;
      };
  };
}
