{ inputs, stateVersion, mainUser, ... }: {
  programs.home-manager.enable = true;
  home.stateVersion = stateVersion;

  imports = [ inputs.catppuccin.homeModules.catppuccin ];

  programs.git = {
    enable = true;
    userName = mainUser.githubUsername;
    userEmail = mainUser.email;
    diff-so-fancy.enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
        hooksPath = "~/.git/hooks";
      };
      pull = {
        rebase = false;
      };
    };
  };

  catppuccin = {
    enable = true;
    flavor = "frappe";
  };

  nixpkgs.config.allowUnfree = true;

  xdg.configFile."nvim".source = inputs.astronvim-config;

  home.file.".elixir".source = "${inputs.elixir-extensions}/extensions";
  home.file.".iex.exs".source = "${inputs.elixir-extensions}/iex.exs";
}
