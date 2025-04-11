{ inputs, stateVersion, mainUser, ... }: {
  programs.home-manager.enable = true;
  home.stateVersion = stateVersion;

  programs.git = {
    enable = true;
    userName = mainUser.githubUsername;
    userEmail = mainUser.email;
    diff-so-fancy.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  xdg.configFile."nvim".source = inputs.astronvim-config;

  home.file.".elixir".source = "${inputs.elixir-extensions}/elixir";
  home.file.".iex.exs".source = "${inputs.elixir-extensions}/iex.exs";
}
