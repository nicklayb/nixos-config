{ pkgs, stateVersion, username, mainUser, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  mods._1password.enable = true;
  mods.alacritty.enable = true;
  mods.bluetooth = {
    enable = true;
    blueman = false;
  };
  mods.plasma.enable = true;
  mods.plasma.withSddm = true;
  mods.printing.enable = true;
  mods.zen.enable = true;

  environment.systemPackages = [
    pkgs.mbpfan
    pkgs.handbrake
    pkgs.abcde
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

