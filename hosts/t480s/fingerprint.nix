{ inputs, ... } : {
  imports = [
    inputs.nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"
  ];

  services.open-fprintd.enable = true;

  security.polkit.enable = true;

  security.pam.services.sddm.fprintAuth = true;

  services."06cb-009a-fingerprint-sensor" = {                                 
    enable = true;                                                            
    backend = "python-validity";                                              
  }; 
}
