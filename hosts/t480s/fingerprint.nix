{ inputs, config, lib, ... } : {
  options = {
    t480s.enrollingMode = lib.mkEnableOption "Enables enrolling mode";
  };
  imports = [
    inputs.nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"
  ];
  config = {
    security.polkit.enable = true;

    security.pam.services.sddm.fprintAuth = true;

    services."06cb-009a-fingerprint-sensor" = {                                 
      enable = true;                                                            
      backend = if config.t480s.enrollingMode then "python-validity" else "libfprint-tod";
      calib-data-file = ./calib-data.bin;
    }; 
  };
}
