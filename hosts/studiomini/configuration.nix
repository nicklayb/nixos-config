{ pkgs, system, username, lib, inputs, home-manager, ... }:

{
  mods.tmux.enable = true;
  users.users.${username} = {
    home = "/Users/${username}";
  };

  environment.systemPackages = with pkgs; [
    wget
    btop
    ripgrep
    fzf
    unzip
    jq
    neovim
    gitAndTools.gitFull
    silver-searcher
    openssh
    direnv
    obsidian
    curl
    efm-langserver
    gnupg
    glow
    unrar
    nodePackages.serve
    lazygit
    rclone
    ffmpeg
    nerdfonts
    oh-my-zsh
    tree-sitter
    nodejs_22
  ];

  environment.variables = {
    EDITOR = "nvim";
  };

  environment.systemPath = [
    "/opt/homebrew/bin"
  ];

  homebrew.enable = true;

  homebrew.brews = [
    "asdf"
  ];

  homebrew.casks = [
    "amethyst"
    "raycast"
    "reaper"
    "1password"
    "slack"
    "alacritty"
    "the-unarchiver"
    "darktable"
  ];

  services.nix-daemon.enable = true;

  programs.zsh = {
    enable = true;
    enableFzfCompletion = true;
    enableFzfGit = true;
    enableSyntaxHighlighting = true;
    interactiveShellInit = ''
      export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/

      ZSH_THEME="eastwood"
      plugins=(git fzf web-search)

      source ${pkgs.oh-my-zsh}/share/oh-my-zsh//oh-my-zsh.sh
      . $(brew --prefix asdf)/libexec/asdf.sh
    '';
    promptInit = "";
  };

  system.stateVersion = 4;

  system.defaults.trackpad.TrackpadThreeFingerDrag = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.hostPlatform = lib.mkDefault system;
}
