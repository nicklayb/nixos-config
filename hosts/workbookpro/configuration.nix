{
  pkgs,
  username,
  system,
  lib,
  ...
}:

{
  mods = {
    fonts.enable = true;
    tmux.enable = true;
    vscode = {
      enable = true;
      cycode = true;
    };
    zen.enable = true;
  };

  ids.gids.nixbld = 350;

  system.primaryUser = username;

  users.users.${username} = {
    home = "/Users/${username}";
  };

  environment = {
    systemPackages = [
      pkgs.wget
      pkgs.btop
      pkgs.ripgrep
      pkgs.fzf
      pkgs.unzip
      pkgs.jq
      pkgs.neovim
      pkgs.gitFull
      pkgs.silver-searcher
      pkgs.openssh
      pkgs.direnv
      pkgs.k9s
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

    variables = {
      EDITOR = "nvim";
    };

    systemPath = [
      "/opt/homebrew/bin"
    ];

    # Enables touch id in tmux
    etc."pam.d/sudo_local".text = ''
      # Managed by Nix Darwin
      auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
      auth       sufficient     pam_tid.so
    '';
  };

  homebrew = {
    enable = true;

    brews = [
      "asdf"
      "cycode"
      "platformio"
    ];

    casks = [
      "amethyst"
    ];
  };

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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.hostPlatform = lib.mkDefault system;
}
