{ pkgs, ... }: {
  imports = [
    ./tmux
  ];

  programs.zsh.enable = true;
  services.openssh.enable = true;

  console = {
    font = "Lat2-Terminus16";
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    btop
    psmisc
    ripgrep
    fzf
    nfs-utils
    unzip
    jq
    neovim
  ];
}
