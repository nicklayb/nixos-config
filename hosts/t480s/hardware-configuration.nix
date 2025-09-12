{ config, lib, modulesPath, pkgs, hostname, system, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "v4l2loopback" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback.out ];

  boot.loader.systemd-boot.enable = true;

  fileSystems."/mnt/windows" = 
    { device = "/dev/disk/by-uuid/42B41F08B41EFDDB";
      fsType = "ntfs";
    };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/f938fabb-fc8a-4a44-88f7-eb115506bda2";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/1317-C3C9";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/d74da650-de57-46b5-9e13-ea5ca1d95fea"; }
    ];

  networking.hostName = hostname;
  networking.networkmanager.enable = true;
  networking.useDHCP = lib.mkDefault true;

  services.pipewire.enable = false;
  hardware.pulseaudio.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = [
      pkgs.vpl-gpu-rt
      pkgs.intel-media-driver
      pkgs.libva
      pkgs.vaapiVdpau
    ];
  };

  nixpkgs.hostPlatform = lib.mkDefault system;
}
