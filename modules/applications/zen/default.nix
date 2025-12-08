{ config, lib, username, inputs, system, ... }: let
  mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
    install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
    installation_mode = "force_installed";
  });
  fileSpaces = import ./spaces.nix { lib = lib; };
  containers = {
    Personal = {
      color = "purple";
      icon = "pet";
      id = 1;
    };
    Work = {
      color = "blue";
      icon = "briefcase";
      id = 2;
    };
    Shopping = {
      color = "yellow";
      icon = "cart";
      id = 3;
    };
    Dev = {
      color = "pink";
      icon = "fingerprint";
      id = 4;
    };
  };
  pins = {
    "hex/phoenix_live_view" = {
      title = "Hexdocs - Phoenix Live View";
      id = "79862301-ec33-4c0d-8b7e-88ea1715643d";
      url = "https://hexdocs.pm/phoenix_live_view";
      container = containers."Dev".id;
      workspace = spaces."Dev".id;
      position = 1000;
      editedTitle = true;
    };
  };
  spaces = {
    "Personal" = {
      id = "ec9acdc5-c69a-496a-a7ac-7ca230537214";
      icon = "🏠";
      container = containers."Personal".id;
      position = 1000;
    };
    "Shopping" = {
      id = "0eeb858e-5f70-4e29-8a9c-d69a2b1e447b";
      icon = "💸";
      container = containers."Shopping".id;
      position = 2000;
    };
    "Dev" = {
      id = "0d38b887-831a-42e7-8ee2-21aaa04fdf14";
      icon = "👓";
      container = containers."Dev".id;
      position = 3000;
    };
    "Work" = {
      id = "77597019-492d-4ffd-ad3a-a5232f0b86cf";
      icon = "🏒";
      container = containers."Work".id;
      position = 4000;
    };
  };
  locked = value: {
    "Value" = value;
    "Status" = "locked";
  };
in {
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
          ExtensionSettings = mkExtensionSettings {
            "{d634138d-c276-4fc8-924b-40a0ea21d284}" = "1password-x-password-manager";
            "uBlock0@raymondhill.net" = "ublock-origin";
            "@testpilot-containers" = "multi-account-containers";
          };
        };
        profiles."default" = {
          settings = {
            "zen.welcome-screen.seen" = locked true;
            "zen.view.compact.enable-at-startup" = locked true;
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
    environment.etc."1password/custom_allowed_browsers" = {
      text = ''
        .zen-wrapped
      '';
      mode = "0755";
    };
  };
}
