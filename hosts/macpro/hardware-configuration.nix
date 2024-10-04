{ config, lib, pkgs, modulesPath, hostname, system, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" "xhci_pci" "firewire_ohci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "wl" "kvm-amd" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta  ];
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/4a158cf1-7e9e-40ca-a87f-b4960e4ede0f";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/64AA-D0C8";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/sda2"; }
    ];

  networking.useDHCP = lib.mkDefault true;
  networking.hostName = hostname;

  services.pipewire.enable = false;
  hardware.pulseaudio.enable = true;

  hardware.opengl.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault system;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
