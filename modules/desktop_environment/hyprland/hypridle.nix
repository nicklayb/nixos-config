{ pkgs, timers, ... }:
let
  # Runs hyprlock while mirroring its state into logind's LockedHint, which
  # hyprlock does not set itself. Tools that follow logind (e.g. the immurok
  # daemon) rely on it to know the screen is locked. Setting the hint is
  # best-effort: a failure must never prevent the screen from locking.
  lockSession = pkgs.writeShellApplication {
    name = "hyprlock-session";
    runtimeInputs = [
      pkgs.hyprlock
      pkgs.procps
      pkgs.systemd
    ];
    text = ''
      set_locked_hint() {
        busctl call org.freedesktop.login1 /org/freedesktop/login1/session/auto \
          org.freedesktop.login1.Session SetLockedHint b "$1" || true
      }

      if pgrep -x hyprlock >/dev/null; then
        exit 0
      fi

      set_locked_hint true
      trap 'set_locked_hint false' EXIT
      hyprlock
    '';
  };
in
{
  general = {
    lock_cmd = "${lockSession}/bin/hyprlock-session";
    # Triggered by `loginctl unlock-session` (logind Unlock signal); SIGUSR1 makes hyprlock unlock.
    unlock_cmd = "${pkgs.procps}/bin/pkill -USR1 -x hyprlock";
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
