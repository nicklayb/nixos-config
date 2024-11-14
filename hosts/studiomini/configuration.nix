{ pkgs, system, lib, inputs, home-manager, ... }:

{
  mods.tmux.enable = true;

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
  ];

  services.nix-daemon.enable = true;

  programs.zsh = {
    enable = true;
    enableFzfCompletion = true;
    enableFzfGit = true;
    enableSyntaxHighlighting = true;
    interactiveShellInit = ''
      . $(brew --prefix asdf)/libexec/asdf.sh
    '';
  };

  system.stateVersion = 4;

  system.defaults.trackpad.TrackpadThreeFingerDrag = true;

  nixpkgs.config.allowUnfree = true;

  nixpkgs.hostPlatform = lib.mkDefault system;
}
