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
    "usbhid"
    "usb_storage"
    "sd_mod"
    "sdhci_pci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [
    "kvm-intel"
    "wl"
  ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/686ba624-564d-45da-80ea-c4b3272922e8";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/6D91-00C9";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/57ba592f-7fdf-4726-b1ae-54490583abc4"; }
  ];

  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;
  networking.hostName = hostname;

  services.pipewire.enable = false;
  services.pulseaudio.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault system;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
