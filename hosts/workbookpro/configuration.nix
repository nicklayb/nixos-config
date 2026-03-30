{
  pkgs,
  username,
  system,
  lib,
  ...
}:

{
  mods = {
    alacritty = {
      enable = true;
      fontSize = 13;
    };
    fonts.enable = true;
    tmux.enable = true;
    vscode = {
      enable = true;
      cycode = true;
    };
    darwin_tiling = {
      yabai = {
        enable = true;
        statusBar = "all:0:26";
      };
      skhd.enable = true;
      spacebar.enable = true;
    };
    zen.enable = true;
    local_llm = {
      enable = true;
      dataDir = "/Users/${username}/.local_ai";
    };
  };

  ids.gids.nixbld = 350;

  system.primaryUser = username;

  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.zsh;
    uid = 502;
  };

  users.knownUsers = [ username ];

  environment = {
    systemPackages = [
      pkgs.wget
      pkgs.btop
      pkgs.ripgrep
      pkgs.fzf
      pkgs.unzip
      pkgs.jq
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

      # Allows Touch ID authentication for sudo
      auth       sufficient     pam_tid.so

      # Allows Apple Watch authentication for sudo
      auth       sufficient     ${pkgs.pam-watchid}/lib/pam_watchid.so  
    '';
  };

  homebrew = {
    enable = true;

    brews = [
      "asdf"
      "cycode"
      "platformio"
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
    NSGlobalDomain = {
      AppleShowScrollBars = "Always";
    };
  };

  system.stateVersion = 4;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.hostPlatform = lib.mkDefault system;
}
