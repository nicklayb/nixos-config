{ pkgs, stateVersion, username, mainUser, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  mods._1password.enable = true;
  mods.alacritty.enable = true;
  mods.bluetooth.enable = true;
  mods.docker.enable = true;
  mods.firefox.enable = true;
  mods.nautilus.enable = true;
  mods.plasma.enable = true;
  mods.printing.enable = true;
  mods.sddm.enable = true;
  mods.waybar.enable = true;
  mods.waybar.theme = "rose";
  mods.wofi.enable = true;
  mods.zen.enable = true;

  environment.systemPackages = [
    pkgs.mbpfan
    pkgs.handbrake
  ];

  systemd.services.mbpfan = {
    wantedBy = [ "multi-user.target" ];
    enable = true;
    serviceConfig = {
      User = "root";
      Group = "root";
      ExecStart = "${pkgs.mbpfan}/bin/mbpfan -f";
    };
  };

  users.users.${username} = {
    isNormalUser = true;
    description = mainUser.name;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  users.users.evelynn = {
    isNormalUser = true;
    description = "Eve-Lynn Laforme";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = stateVersion;
}

