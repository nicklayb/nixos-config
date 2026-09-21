{
  pkgs,
  username,
  system,
  lib,
  inputs,
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
    mise.enable = true;
    vscode = {
      enable = true;
      cycode = true;
    };
    darwin_tiling = {
      yabai = {
        enable = true;
        # statusBar = "all:0:26";
      };
      skhd.enable = false;
      spacebar.enable = false;
    };
    zen.enable = true;
    zsh = {
      enable = true;
      extraContent = ''
        export PATH="''${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
      '';
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
      pkgs.asdf-vm
      pkgs.awscli2
      pkgs.btop
      pkgs.cargo
      pkgs.colima
      pkgs.coreutils
      pkgs.curl
      pkgs.direnv
      pkgs.docker
      pkgs.docker-compose
      pkgs.efm-langserver
      pkgs.ffmpeg
      pkgs.fzf
      pkgs.gitFull
      pkgs.glow
      pkgs.gnupg
      pkgs.ijq
      pkgs.jq
      pkgs.just
      pkgs.k9s
      pkgs.kubectl
      pkgs.kubectx
      pkgs.lazygit
      pkgs.mas
      pkgs.obsidian
      pkgs.openssh
      pkgs.pam-reattach
      pkgs.postgresql_15
      pkgs.prototool
      pkgs.rclone
      pkgs.ripgrep
      pkgs.silver-searcher
      pkgs.smartmontools
      pkgs.unrar
      pkgs.unzip
      pkgs.weechat
      pkgs.wget
      pkgs.xz
      pkgs.zlib
      pkgs.zsh-autosuggestions
      inputs.squix.packages.${system}.default
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
      orientation = "left";
      show-recents = false;
    };

    controlcenter = {
      BatteryShowPercentage = true;
    };
    NSGlobalDomain = {
      AppleShowScrollBars = "Always";
    };
  };

  services.mutty-companion.enable = true;

  system.stateVersion = 4;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.hostPlatform = lib.mkDefault system;
}
