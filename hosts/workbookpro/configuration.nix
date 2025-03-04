{ pkgs, system, lib, ... }:

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
    k9s
    kubectx
    kubectl
    docker
    docker-compose
    coreutils
    obsidian
    curl
    efm-langserver
    gnupg
    colima
    mas
    glow
    unrar
    awscli2
    nodePackages.serve
    lazygit
    smartmontools
    prototool
    xz
    zlib
    ijq
    rclone
    weechat
    ffmpeg
    pam-reattach
    zsh-autosuggestions
    just
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
    "platformio"
  ];

  homebrew.casks = [
    "amethyst"
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

      source ${pkgs.oh-my-zsh}/share/oh-my-zsh/oh-my-zsh.sh
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      . $(brew --prefix asdf)/libexec/asdf.sh
    '';
    promptInit = "";
  };

  system.stateVersion = 4;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.hostPlatform = lib.mkDefault system;
}
