{ pkgs, mainUser, inputs, ... }: {

  home-manager.users.${mainUser.username} = {
    home.file.".mozilla/firefox/${mainUser.username}/chrome/firefox-mod-blur".source = inputs.firefox-mod-blur;
    programs.firefox = {
      enable = true;
      profiles.${mainUser.username} = {
        userChrome = ''
          @import "firefox-mod-blur/userChrome.css";
        '';
        userContent = ''
          @import "firefox-mod-blur/userContent.css";
        '';
        settings = {
          "browser.theme.content-theme" = 0;
          "browser.theme.dark-private-windows" = false; 
          "browser.theme.toolbar-theme" = 0;
          "browser.uidensity" = 0;
          "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          "services.sync.engine.passwords" = false;
          "svg.context-properties.content.enabled" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    firefox
    krita
    mailspring
    neovim
    pavucontrol
    vlc
  ];
}
