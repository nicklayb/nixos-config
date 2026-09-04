{
  config,
  lib,
  pkgs,
  modulesPath,
  hostname,
  system,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "vmd"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "sr_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [
    "kvm-intel"
  ];
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d849a473-2322-4544-af66-77f27755974b";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/12CE-A600";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/f4ff513c-8fa1-493d-81fe-c070d7e5b4b7"; }
  ];

  networking.useDHCP = lib.mkDefault true;
  networking.hostName = hostname;

  networking.networkmanager.ensureProfiles = {
    profiles = {
      bridge0 = {
        connection = {
          id = "bridge0";
          type = "bridge";
          interface-name = "bridge0";
          autoconnect = true;
        };

        bridge = {
          stp = true;
        };

        ethernet = {
          cloned-mac-address = "02:00:00:00:00:58";
        };

        ipv4 = {
          method = "auto";
        };

        ipv6 = {
          method = "auto";
        };
      };

      bridge0-eno1 = {
        connection = {
          id = "bridge0-eno1";
          type = "ethernet";
          interface-name = "eno1";
          master = "bridge0";
          slave-type = "bridge";
          autoconnect = true;
        };
      };
    };
  };

  hardware.graphics.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault system;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
