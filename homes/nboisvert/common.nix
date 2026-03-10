{
  inputs,
  stateVersion,
  mainUser,
  config,
  username,
  pkgs,
  ...
}:
{
  programs.home-manager.enable = true;
  home.username = username;
  home.stateVersion = stateVersion;

  imports = [
    inputs.catppuccin.homeModules.catppuccin
    inputs.zen-browser.homeModules.twilight
    inputs.astronvim-config.homeManagerModules.default
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

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "fzf"
        "web-search"
      ];
      theme = "eastwood";
    };
    initContent = ''
      source ~/.zsh/init || true
    '';
  };

  programs.diff-so-fancy = {
    enable = true;
    enableGitIntegration = true;
  };

  catppuccin = {
    enable = true;
    flavor = "frappe";
  };

  home.file.".git/hooks/prepare-commit-msg" = {
    source = ./scripts/prepare-commit-msg;
    executable = true;
  };

  home.file.".elixir".source = "${inputs.elixir-extensions}/extensions";
  home.file.".iex.exs".source = "${inputs.elixir-extensions}/iex.exs";
}
