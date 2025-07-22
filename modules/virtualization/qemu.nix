{ config, lib, pkgs, username, ... }: {
  options = {
    mods.virtualization.qemu = {
      enable = lib.mkEnableOption "Enables QEMU/KVM";
    };
  };
  config = lib.mkIf config.mods.virtualization.qemu.enable {
    virtualisation.libvirtd.enable = true;
    environment.systemPackages = [
      pkgs.qemu
    ];
    programs.virt-manager.enable = true;
    users.users.${username}.extraGroups = [ "qemu-libvirtd" "libvirtd" ];
  };
}
