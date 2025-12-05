{ config, lib, username, inputs, system, ... }: {
  options = {
    mods.zen = {
      enable = lib.mkEnableOption "Enables Zen Browser";
    };
  };
  config = lib.mkIf config.mods.zen.enable {
    home-manager.users.${username} = {
      programs.zen-browser = {
        enable = true;
        policies = {
          AutofillAddressEnabled = true;
          AutofillCreditCardEnabled = false;
          DisableAppUpdate = true;
          DisableFeedbackCommands = true;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DontCheckDefaultBrowser = true;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };
        };
      };
    };
    environment.etc."1password/custom_allowed_browsers" = {
      text = ''
        .zen-wrapped
        .zen-beta-wrapped
      '';
      mode = "0755";
    };
  };
}
