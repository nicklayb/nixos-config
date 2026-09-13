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
    nix.buildMachines = [
      {
        hostName = "nix-aarch.nboisvert.local";
        system = "aarch64-linux";
        sshUser = "builder";
        sshKey = "/root/.ssh/nix-builder";
        maxJobs = 8;
        protocol = config.mods.distributedBuilders.protocol;
      }
    ];
  };
}
