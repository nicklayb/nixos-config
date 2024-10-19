{ config, lib, pkgs, modulesPath, system, hostname, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/3503b7cc-19c5-4368-88cf-44f5d528bec8";
      fsType = "ext4";
    };

  swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];

  networking.hostName = hostname;
  networking.networkmanager.enable = true;
  networking.useDHCP = lib.mkDefault true;
  services.pipewire.enable = false;
  hardware.pulseaudio.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault system;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
