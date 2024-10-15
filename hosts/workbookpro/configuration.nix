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

  programs.zsh.enable = true;

  system.stateVersion = 4;

  nixpkgs.config.allowUnfree = true;

  nixpkgs.hostPlatform = lib.mkDefault system;
}
