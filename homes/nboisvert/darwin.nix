{ stateVersion, username, ... }: {
  home.stateVersion = stateVersion;
  home.username = username;

  programs.home-manager.enable = true;
}
