{ config, lib, pkgs, username, ... }: {
  options = {
    mods.virtualization.qemu = {
      enable = lib.mkEnableOption "Enables QEMU/KVM";
    };
  };
  config = lib.mkIf config.mods.virtualization.qemu.enable {
    virtualisation.libvirtd.enable = true;
    environment.systemPackages = [
      pkgs.virt-manager
      pkgs.qemu
    ];
    users.users.${username}.extraGroups = [ "qemu-libvirtd" "libvirtd" ];
  };
}
