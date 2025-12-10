{ config, lib, username, pkgs, inputs, system, ... }:
let
  mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
    install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
    installation_mode = "force_installed";
  });
  fileSpaces = import ./spaces { lib = lib; };
  locked = value: {
    "Value" = value;
    "Status" = "locked";
  };
  linuxSpecific = (if pkgs.stdenv.isLinux then
    {
      environment.etc."1password/custom_allowed_browsers" = {
        text = ''
          .zen-wrapped
        '';
        mode = "0755";
      };
    }
  else
    { });
in
{
  options = {
    mods.zen = {
      enable = lib.mkEnableOption "Enables Zen Browser";
    };
  };
  config = lib.mkIf config.mods.zen.enable
    {
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
            ExtensionSettings = mkExtensionSettings {
              "{d634138d-c276-4fc8-924b-40a0ea21d284}" = "1password-x-password-manager";
              "uBlock0@raymondhill.net" = "ublock-origin";
              "@testpilot-containers" = "multi-account-containers";
            };
          };
          profiles."default" = {
            settings = {
              "zen.welcome-screen.seen" = locked true;
              "zen.view.use-single-toolbar" = locked false;
              "zen.workspaces.force-container-workspace" = locked true;
            };
            spacesForce = true;
            containersForce = true;
            pinsForce = true;
            containers = fileSpaces.containers;
            pins = fileSpaces.pins;
            spaces = fileSpaces.spaces;
            # containers = containers;
            # pins = pins;
            # spaces = spaces;
          };
        };
      };
    } // linuxSpecific;
}
