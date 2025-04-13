{ stateVersion, username, ... }: {
  imports = [
    ./common.nix
    ./darwin
  ];

  home.stateVersion = stateVersion;
  home.username = username;

  programs.home-manager.enable = true;
}
