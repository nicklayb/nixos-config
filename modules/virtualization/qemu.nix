{
  config,
  lib,
  pkgs,
  username,
  ...
}:
{
  options = {
    mods.virtualization.qemu = {
      enable = lib.mkEnableOption "Enables QEMU/KVM";
    };
  };
  config = lib.mkIf config.mods.virtualization.qemu.enable {
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
      };
      spiceUSBRedirection.enable = true;
    };
    environment.systemPackages = [
      pkgs.qemu
      pkgs.spice
      pkgs.spice-gtk
    ];
    programs.virt-manager.enable = true;
    users.users.${username}.extraGroups = [
      "qemu-libvirtd"
      "libvirtd"
    ];
  };
}
