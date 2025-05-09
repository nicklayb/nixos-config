{ inputs, stateVersion, mainUser, ... }: {
  programs.home-manager.enable = true;
  home.stateVersion = stateVersion;

  imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];

  programs.git = {
    enable = true;
    userName = mainUser.githubUsername;
    userEmail = mainUser.email;
    diff-so-fancy.enable = true;
  };

  catppuccin = {
    enable = true;
    catppuccin.flavor = "frappe";
  };

  nixpkgs.config.allowUnfree = true;

  xdg.configFile."nvim".source = inputs.astronvim-config;

  home.file.".elixir".source = "${inputs.elixir-extensions}/extensions";
  home.file.".iex.exs".source = "${inputs.elixir-extensions}/iex.exs";
}
