{
  pkgs,
  username,
  ...
}:
{
  imports = [
    ./common.nix
  ];
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages = [
    pkgs.slack
    pkgs.elixir
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_INSECURE = "1";
    NIXOS_OZONE_WL = "1";
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
  };

  # Scripts
  xdg.configFile."scripts/power-menu.sh".source = ./scripts/power-menu.sh;
  xdg.configFile."scripts/wikis.sh".source = ./scripts/wikis.sh;
  xdg.configFile."scripts/monitors.sh".source = ./scripts/monitors.sh;
  xdg.configFile."scripts/sync-photo.sh".source = ./scripts/sync-photo.sh;
}
