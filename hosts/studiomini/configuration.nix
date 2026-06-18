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
      nodePackages.serve
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
