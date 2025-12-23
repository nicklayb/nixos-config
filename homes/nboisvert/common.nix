{
  inputs,
  stateVersion,
  mainUser,
  config,
  ...
}:
{
  programs.home-manager.enable = true;
  home.stateVersion = stateVersion;

  imports = [
    inputs.catppuccin.homeModules.catppuccin
    inputs.zen-browser.homeModules.twilight
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = mainUser.githubUsername;
        email = mainUser.email;
      };
      init = {
        defaultBranch = "main";
      };
      core = {
        hooksPath = "${config.home.homeDirectory}/.git/hooks";
      };
      pull = {
        rebase = false;
      };
    };
  };

  programs.diff-so-fancy = {
    enable = true;
    enableGitIntegration = true;
  };

  catppuccin = {
    enable = true;
    flavor = "frappe";
  };

  xdg.configFile."nvim".source = inputs.astronvim-config;

  home.file.".git/hooks/prepare-commit-msg" = {
    source = ./scripts/prepare-commit-msg;
    executable = true;
  };

  home.file.".elixir".source = "${inputs.elixir-extensions}/extensions";
  home.file.".iex.exs".source = "${inputs.elixir-extensions}/iex.exs";
}
