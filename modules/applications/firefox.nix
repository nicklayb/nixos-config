{ config, lib, mainUser, pkgs, inputs, ... }: {
  options = {
    mods.firefox = {
      enable = lib.mkEnableOption "Enables Firefox";
      theme = lib.mkOption {
        description = "Theme to apply";
        default = "textfox";
        type = lib.types.str;
      };
    };
  };
  config = lib.mkIf config.mods.firefox.enable {
    environment.systemPackages = [
      pkgs.firefox
    ];

    home-manager.users.${mainUser.username} = {
      home.file.".mozilla/firefox/${mainUser.username}/chrome/firefox-mod-blur".source = inputs.firefox-firefox-mod-blur;
      home.file.".mozilla/firefox/${mainUser.username}/chrome/textfox".source = inputs.firefox-textfox;
      programs.firefox = {
        enable = true;
        profiles.${mainUser.username} = let
          rosePineMoonThemeID = "{a046d296-3ec9-40f8-a15c-db401fb7d8e7}";
        in {
          userChrome = ''
            @import "${config.mods.firefox.theme}/userChrome.css";
          '';
          userContent = ''
            @import "${config.mods.firefox.theme}/userContent.css";
          '';
          settings = {
            "browser.theme.content-theme" = 0;
            "browser.theme.dark-private-windows" = false; 
            "browser.theme.toolbar-theme" = 0;
            "browser.uidensity" = 0;
            "extensions.activeThemeID" = rosePineMoonThemeID;
            "services.sync.engine.passwords" = false;
            "svg.context-properties.content.enabled" = true;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          };
        };
      };
    };
  };
}
