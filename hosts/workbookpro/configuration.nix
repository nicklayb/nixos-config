{ pkgs, unstable-pkgs, system, lib, ... }:

{
  mods.tmux.enable = true;

  environment.systemPackages = [
    pkgs.wget
    pkgs.btop
    pkgs.ripgrep
    pkgs.fzf
    pkgs.unzip
    pkgs.jq
    pkgs.neovim
    pkgs.gitAndTools.gitFull
    pkgs.silver-searcher
    pkgs.openssh
    pkgs.direnv
    unstable-pkgs.k9s
    pkgs.kubectx
    pkgs.kubectl
    pkgs.docker
    pkgs.docker-compose
    pkgs.coreutils
    pkgs.obsidian
    pkgs.curl
    pkgs.efm-langserver
    pkgs.gnupg
    pkgs.colima
    pkgs.mas
    pkgs.glow
    pkgs.unrar
    pkgs.awscli2
    pkgs.nodePackages.serve
    pkgs.lazygit
    pkgs.smartmontools
    pkgs.prototool
    pkgs.xz
    pkgs.zlib
    pkgs.ijq
    pkgs.rclone
    pkgs.weechat
    pkgs.ffmpeg
    pkgs.pam-reattach
    pkgs.zsh-autosuggestions
    pkgs.just
    pkgs.postgresql_15
    pkgs.cargo
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

  system.defaults = {
    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };

    dock = {
      orientation = "right";
      show-recents = false;
    };

    controlcenter = {
      BatteryShowPercentage = true;
    };
  };

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
