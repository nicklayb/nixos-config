{ config, lib, ... }: {
  options = {
    mods.distributedBuilders = {
      enable = lib.mkEnableOption "Enables Distributed Builders";
      protocol = lib.mkOption {
        type = lib.types.enum [
          "ssh"
          "ssh-ng"
        ];
        default = "ssh";
        description = "Connection protocol";
      };
    };
  };
  config = lib.mkIf config.mods.distributedBuilders.enable {
    nix.distributedBuilds = true;

    programs.ssh.extraConfig = ''
      Host nix-aarch
        HostName nix-aarch.nboisvert.local
        Port 31022
        User builder
        IdentityFile /root/.ssh/nix-builder
        HostKeyAlias nix-aarch
    '';
    nix.buildMachines = [
      {
        hostName = "nix-aarch";
        system = "aarch64-linux";
        sshUser = "builder";
        sshKey = "/root/.ssh/nix-builder";
        # Fixed host key of nix-darwin's linux-builder VM (nix-darwin modules/nix/linux-builder.nix)
        publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUpCV2N4Yi9CbGFxdDFhdU90RStGOFFVV3JVb3RpQzVxQkorVXVFV2RWQ2Igcm9vdEBuaXhvcwo=";
        maxJobs = 4;
        protocol = config.mods.distributedBuilders.protocol;
      }
    ];
    nix.settings.builders-use-substitutes = true;
  };
}
