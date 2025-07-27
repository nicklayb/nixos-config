{ config, lib, username, ... }: {
  options = {
    mods.virtualization.virtualbox = {
      enable = lib.mkEnableOption "Enables VirtualBox";
    };
  };
  config = lib.mkIf config.mods.virtualization.virtualbox.enable {
    virtualisation.virtualbox.guest.enable = true;
    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableExtensionPack = true;
    users.extraGroups.vboxusers.members = [ username ];
  };
}
