{ config, lib, ... }: {
  options = {
    locale.keyboard = {
      layout = lib.mkOption {
        description = "Keyboard layout";
        default = "ca";
        type = lib.types.str;
      };
      variant = lib.mkOption {
        description = "Keyboard layout variant";
        default = "multix";
        type = lib.types.str;
      };
    };
    locale.clock = {
      timezone = lib.mkOption {
        description = "Timezone";
        default = "America/Montreal";
        type = lib.types.str;
      };
    };
    locale.mainLocale = lib.mkOption {
      description = "Default locale used by the system";
      type = lib.types.str;
      default = "fr_CA.UTF-8";
    };
  };
  config = {
    i18n.defaultLocale = config.locale.mainLocale;
    time.timeZone = config.locale.clock.timezone;
    services.xserver.xkb.layout = config.locale.keyboard.layout;
    services.xserver.xkb.variant = config.locale.keyboard.variant;
    console.useXkbConfig = true;
  };
}
