{ config, lib, system, hostname, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.loader.systemd-boot.enable = true;
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" "v4l2loopback" ];
  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback.out ];
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/1faf9eaf-eba4-4bc5-bbd9-7c1ae8037e89";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/5847-D813";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/media/ssd" =
    { device = "/dev/disk/by-uuid/D49650D19650B628";
      fsType = "ntfs-3g";
      options = ["rw" "uid=1000"];
    };

  fileSystems."/media/ssd_pcie" =
    { device = "/dev/disk/by-uuid/2EB4B14EB4B11973";
      fsType = "ntfs-3g";
      options = ["rw" "uid=1000"];
    };

  fileSystems."/media/ssd_m2" =
    { device = "/dev/disk/by-uuid/7A4848E94848A5AB";
      fsType = "ntfs-3g";
      options = ["rw" "uid=1000"];
    };

  fileSystems."/media/nouveau_volume" =
    { device = "/dev/disk/by-uuid/9E380E50380E27BB";
      fsType = "ntfs-3g";
      options = ["rw" "uid=1000"];
    };

  fileSystems."/media/new_volume" =
    { device = "/dev/disk/by-uuid/609CDD999CDD6A54";
      fsType = "ntfs-3g";
      options = ["rw" "uid=1000"];
    };

  fileSystems."/media/plugins" =
    { device = "/dev/disk/by-uuid/B65613E35613A363";
      fsType = "ntfs-3g";
      options = ["rw" "uid=1000"];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/f092cf58-36b8-4431-8e2e-8a70b34479f4"; }
    ];

  networking.useDHCP = lib.mkDefault true;
  networking.hostName = hostname;
  nixpkgs.hostPlatform = lib.mkDefault system;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;

    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
