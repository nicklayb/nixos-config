{ pkgs, mainUser, stateVersion, inputs, ... }: {
  home.stateVersion = stateVersion;
  home.username = mainUser.username;
  # xdg.configFile."nvim".source = inputs.astronvim-config;
}
