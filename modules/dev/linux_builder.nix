# Runs an aarch64-linux NixOS VM (QEMU) on macOS as a Nix remote builder,
# usable locally by nix-darwin and by other LAN hosts over SSH.
{
  config,
  lib,
  ...
}:

let
  cfg = config.mods.linuxBuilder;

  mebibytesPerGibibyte = 1024;

  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  customConfiguration = {
    virtualisation = {
      cores = cfg.cores;
      darwin-builder = {
        memorySize = cfg.memoryGibibytes * mebibytesPerGibibyte;
        diskSize = cfg.diskGibibytes * mebibytesPerGibibyte;
      };
    };

    users.users.builder.openssh.authorizedKeys.keys = cfg.remoteAuthorizedKeys;
  };
in
{
  options.mods.linuxBuilder = {
    enable = mkEnableOption "an aarch64-linux Nix builder VM";

    isBootstrapped = mkOption {
      type = types.bool;
      default = false;

      description = ''
        Whether the default builder already runs on this machine.

        Leave to false on first activation: the stock VM image is fetched
        from cache.nixos.org. Any customization changes the image and must
        be built by an existing Linux builder, so only set this to true
        once the stock builder is running.
      '';
    };

    isEphemeral = mkOption {
      type = types.bool;
      default = false;

      description = ''
        Whether to wipe the builder's disk (including its Nix store) on every restart.
      '';
    };

    cores = mkOption {
      type = types.ints.positive;
      default = 4;
      description = "Virtual CPU count, also used as the builder's max jobs.";
    };

    memoryGibibytes = mkOption {
      type = types.ints.positive;
      default = 8;
      description = "Memory allocated to the VM, in GiB.";
    };

    diskGibibytes = mkOption {
      type = types.ints.positive;
      default = 64;
      description = ''
        Maximum disk size of the VM, in GiB.

        Only used when the disk image is created: delete the existing image
        (`/var/lib/linux-builder/nixos.qcow2`) for a new size to take effect.
      '';
    };

    remoteAuthorizedKeys = mkOption {
      type = types.listOf types.str;
      default = [ ];

      description = ''
        SSH public keys allowed to log in as the `builder` user from other hosts.

        The VM's SSH port (31022) is forwarded on every host interface.
      '';
    };
  };

  config = mkIf cfg.enable {
    warnings = lib.optional (!cfg.isBootstrapped) ''
      mods.linuxBuilder.isBootstrapped is false: cores, memory, disk size and
      remote authorized keys are ignored and the stock builder defaults apply.
    '';

    nix.linux-builder = {
      enable = true;
      ephemeral = cfg.isEphemeral;
      config = mkIf cfg.isBootstrapped customConfiguration;
    };
  };
}
