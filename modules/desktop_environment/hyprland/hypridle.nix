{ timers, ... }: {
  general = {
    lock_cmd = "pidof hyprlock || hyprlock";
    before_sleep_cmd = "loginctl lock-session";
    after_sleep_cmd = "hyprctl dispatch dpms on";
  };

  listener = [
    {
      timeout = timers.sleep;
      on-timeout = "systemctl suspend";
    }
    {
      timeout = timers.lock;
      on-timeout = "loginctl lock-session";
    }
  ];
}
