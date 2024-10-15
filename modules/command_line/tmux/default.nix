{ config, pkgs, lib, ... }: {
  options = {
    mods.tmux = {
      enable = lib.mkEnableOption "Enables Tmux";
    };
  };

  config = lib.mkIf config.mods.tmux.enable {
    programs.tmux = {
      enable = true;
      enableFzf = true;
      enableMouse = true;
      extraConfig = builtins.readFile ./tmux.conf;
    };
  };
}
