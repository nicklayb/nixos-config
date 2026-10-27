{
  pkgs,
  system,
  username,
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
    darwin_tiling = {
      yabai = {
        enable = true;
      };
      skhd.enable = false;
      spacebar.enable = false;
    };
    local_llm = {
      enable = true;

      ollama = {
        host = "0.0.0.0";
      };

      models = [
        "qwen3:8b"
        "nomic-embed-text"
        "qwen3-coder:30b"
      ];
    };
    linuxBuilder = {
      enable = true;
      isBootstrapped = false;
      cores = 4;
      memoryGibibytes = 4;
      remoteAuthorizedKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH81bTPl401LcgfiCQPVtS2TDmB9zsc3NOz4qzjy3Qif root@hades"
      ];
    };
    virtualization.colima.enable = true;
    zen.enable = true;
    zsh = {
      enable = true;
    };
  };
  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.zsh;
    uid = 501;
  };

  users.knownUsers = [ username ];

  system.primaryUser = username;

  ids.gids.nixbld = 350;

  services.recording-monitor = {
    enable = true;
    configFile = "/Users/${username}/.config/recording-monitor.yaml";
  };

  environment = {
    systemPackages = with pkgs; [
      wget
      btop
      ripgrep
      fzf
      unzip
      jq
      gitFull
      silver-searcher
      openssh
      direnv
      obsidian
      curl
      efm-langserver
      gnupg
      glow
      unrar
      serve
      lazygit
      rclone
      ffmpeg
      oh-my-zsh
      tree-sitter
      nodejs_22
    ];

    variables = {
      EDITOR = "nvim";
    };
    systemPath = [
      "/opt/homebrew/bin"
    ];
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };

    brews = [
      "asdf"
    ];

    casks = [
      "raycast"
      "reaper"
      "1password"
      "slack"
      "alacritty"
      "the-unarchiver"
      "darktable"
    ];
  };

  system.defaults = {
    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };

    dock = {
      orientation = "bottom";
      show-recents = false;
    };

  };

  system.stateVersion = 4;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.hostPlatform = lib.mkDefault system;
}
