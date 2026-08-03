{ monitor, config, ... }:
{
  "$terminal" = "alacritty";
  "$browser" = "zen-twilight";
  "$fileManager" = "dolphin";
  "$menu" = "pgrep -x wofi >/dev/null 2>&1 || wofi --show drun";
  "$mainMod" = "SUPER";

  exec-once = [
    "waybar"
    "lxqt-policykit-agent"
  ]
  ++ config.mods.hyprland.extraExecOnce;

  env = [
    "XCURSOR_SIZE,24"
    "HYPRCURSOR_SIZE,24"
  ];

  general = {
    gaps_in = config.mods.hyprland.gaps;
    gaps_out = config.mods.hyprland.gaps;
    border_size = 2;
    "col.active_border" = "rgba(ff65baee) rgba(ffab7dee) 45deg";
    "col.inactive_border" = "rgba(595959aa)";
    resize_on_border = false;
    allow_tearing = "false";
    layout = "dwindle";
  };

  decoration = {
    rounding = 8;
    active_opacity = 0.98;
    inactive_opacity = 0.96;
    dim_inactive = config.mods.hyprland.dimInactive;
    blur = {
      enabled = true;
      size = 3;
      passes = 1;
      vibrancy = 0.1696;
    };
  };
  cursor = {
    inactive_timeout = config.mods.hyprland.cursorInactiveTimeout;
  };
  animations = {
    enabled = true;
    # Ease curves: https://easings.net/
    bezier = [
      "easeInOut, 0.83, 0, 0.17, 1"
    ];
    animation = [
      "windows, 1, 6, easeInOut, slide"
      "windowsOut, 1, 6, default, slide"
      "border, 1, 10, default"
      "borderangle, 1, 8, default"
      "fade, 1, 6, default"
      "workspaces, 1, 6, easeInOut"
    ];
  };
  dwindle = {
    preserve_split = true;
  };
  master = {
    new_status = "master";
  };

  misc = {
    force_default_wallpaper = -1;
    disable_hyprland_logo = false;
  };
  input = {
    kb_layout = "ca";
    kb_variant = "multix";
    kb_model = "";
    kb_options = "";
    kb_rules = "";
    follow_mouse = 1;
    sensitivity = 0;
    touchpad = {
      natural_scroll = false;
      disable_while_typing = false;
    };
  };

  gesture = config.mods.hyprland.gestures;

  device = {
    name = "epic-mouse-v1";
    sensitivity = -0.5;
  };
  bind = [
    "$mainMod, RETURN, exec, uwsm app -- $terminal"
    "$mainMod SHIFT, Q, killactive,"
    "$mainMod, E, exec, $fileManager"
    "$mainMod, Z, exec, $browser"
    "$mainMod, V, togglefloating,"
    "$mainMod, D, exec, $menu"
    "$mainMod, P, exec, ~/.config/scripts/power-menu.sh"
    "$mainMod, W, exec, ~/.config/scripts/wikis.sh"
    "$mainMod, J, layoutmsg, togglesplit, # dwindle"
    "$mainMod, L, exec, loginctl lock-session"
    "$mainMod SHIFT, F, fullscreen"
    "$mainMod, X, exec, hyprshot --clipboard-only -m output"
    "$mainMod SHIFT, P, exec, 1password --quick-access"
    "$mainMod SHIFT, X, exec, hyprshot --clipboard-only -m region"
    ", Print, exec, hyprshot --clipboard-only -m region"

    "$mainMod, left, movefocus, l"
    "$mainMod, right, movefocus, r"
    "$mainMod, up, movefocus, u"
    "$mainMod, down, movefocus, d"

    "$mainMod, 1, workspace, 1"
    "$mainMod, 2, workspace, 2"
    "$mainMod, 3, workspace, 3"
    "$mainMod, 4, workspace, 4"
    "$mainMod, 5, workspace, 5"
    "$mainMod, 6, workspace, 6"
    "$mainMod, 7, workspace, 7"
    "$mainMod, 8, workspace, 8"
    "$mainMod, 9, workspace, 9"
    "$mainMod, 0, workspace, 10"

    "$mainMod ALT, 1, layoutmsg, splitratio 0.2 exact"
    "$mainMod ALT, 2, layoutmsg, splitratio 0.4 exact"
    "$mainMod ALT, 3, layoutmsg, splitratio 0.6 exact"
    "$mainMod ALT, 4, layoutmsg, splitratio 0.8 exact"
    "$mainMod ALT, 5, layoutmsg, splitratio 1.0 exact"
    "$mainMod ALT, 6, layoutmsg, splitratio 1.2 exact"
    "$mainMod ALT, 7, layoutmsg, splitratio 1.4 exact"
    "$mainMod ALT, 8, layoutmsg, splitratio 1.6 exact"
    "$mainMod ALT, 9, layoutmsg, splitratio 1.8 exact"

    "$mainMod SHIFT, 1, movetoworkspace, 1"
    "$mainMod SHIFT, 2, movetoworkspace, 2"
    "$mainMod SHIFT, 3, movetoworkspace, 3"
    "$mainMod SHIFT, 4, movetoworkspace, 4"
    "$mainMod SHIFT, 5, movetoworkspace, 5"
    "$mainMod SHIFT, 6, movetoworkspace, 6"
    "$mainMod SHIFT, 7, movetoworkspace, 7"
    "$mainMod SHIFT, 8, movetoworkspace, 8"
    "$mainMod SHIFT, 9, movetoworkspace, 9"
    "$mainMod SHIFT, 0, movetoworkspace, 10"

    "$mainMod SHIFT, right, resizewindowpixel, 100 0, activewindow"
    "$mainMod SHIFT, left, resizewindowpixel, -100 0, activewindow"
    "$mainMod SHIFT, up, resizewindowpixel, 0 -100, activewindow"
    "$mainMod SHIFT, down, resizewindowpixel, 0 100, activewindow"

    "$mainMod ALT, right, swapwindow, r"
    "$mainMod ALT, left, swapwindow, l"
    "$mainMod ALT, up, swapwindow, u"
    "$mainMod ALT, down, swapwindow, d"

    "$mainMod, S, togglespecialworkspace, magic"
    "$mainMod SHIFT, S, movetoworkspace, special:magic"

    "$mainMod, mouse_down, workspace, e+1"
    "$mainMod, mouse_up, workspace, e-1"
  ]
  ++ config.mods.hyprland.extraBindings;

  # Bind + L (even when locked) + E (repeat when held)
  bindle = [
    ", XF86AudioRaiseVolume, exec, pactl set-sink-volume 0 +10%"
    ", XF86AudioLowerVolume, exec, pactl set-sink-volume 0 -10%"
  ];
  bindl = [
    ", XF86AudioMute, exec, pactl set-sink-mute 0 toggle"
  ]
  ++ config.mods.hyprland.extraBindingsL;

  # Move/resize windows with mainMod + LMB/RMB and dragging;
  bindm = [
    "$mainMod, mouse:272, movewindow"
    "$mainMod, mouse:273, resizewindow"
  ];

  windowrule =
    let
      pipTitles = [
        "Picture-in-Picture"
        "Incrustation vidéo"
      ];
      makeFloating = title: [
        "match:title ${title}, float on"
        "match:title ${title}, no_dim 1"
        "match:title ${title}, pin on"
        "match:title ${title}, force_rgbx 1"
      ];

      floating = builtins.foldl' (acc: title: acc ++ makeFloating title) [ ] pipTitles;
    in
    [
      "match:class .*, suppress_event maximize"
      "match:title title:(.*)YouTube(.*), no_dim 1"
    ]
    ++ floating;

  monitor = monitor;
}
