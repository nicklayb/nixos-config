{ stateVersion, username, ... }: {
  imports = [
    ./darwin
  ];

  home.stateVersion = stateVersion;
  home.username = username;

  programs.home-manager.enable = true;
}
