{ monitor, config, ... }: {
  "$terminal" = "alacritty";
  "$fileManager" = "dolphin";
  "$menu" = "pgrep -x wofi >/dev/null 2>&1 || wofi --show drun";
  "$mainMod" = "SUPER";

  exec-once = [
    "waybar"
    "lxqt-policykit-agent"
  ];

  env = [
    "XCURSOR_SIZE,24"
    "HYPRCURSOR_SIZE,24"
  ];

  general = {
    gaps_in = 5;
    gaps_out = 5;
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
    # drop_shadow = true;
    dim_inactive = true;
    # shadow_range = 4;
    # shadow_render_power = 3;
    # "col.shadow" = "rgba(1a1a1aee)";
    blur = {
        enabled = true;
        size = 3;
        passes = 1;
        vibrancy = 0.1696;
    };
  };
  animations = {
    enabled = true;
    bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
    animation = [
      "windows, 1, 7, myBezier"
      "windowsOut, 1, 7, default, popin 80%"
      "border, 1, 10, default"
      "borderangle, 1, 8, default"
      "fade, 1, 7, default"
      "workspaces, 1, 6, default"
    ];
  };
  dwindle = {
      pseudotile = true;
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

  gestures = {
      workspace_swipe = false;
  };

  device = {
      name = "epic-mouse-v1";
      sensitivity = -0.5;
  };
  bind = [
    "$mainMod, RETURN, exec, uwsm app -- $terminal"
    "$mainMod SHIFT, Q, killactive,"
    "$mainMod, E, exec, $fileManager"
    "$mainMod, V, togglefloating,"
    "$mainMod, D, exec, $menu"
    "$mainMod, P, exec, ~/.config/scripts/power-menu.sh"
    "$mainMod, W, exec, ~/.config/scripts/wikis.sh"
    "$mainMod, J, togglesplit, # dwindle"
    "$mainMod, L, exec, loginctl lock-session"
    "$mainMod, X, exec, hyprshot --clipboard-only -m output"
    "$mainMod SHIFT, X, exec, hyprshot --clipboard-only -m region"

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

    "$mainMod SHIFT, right, resizeactive, 20 0"
    "$mainMod SHIFT, left, resizeactive, -20 0"
    "$mainMod SHIFT, up, resizeactive, 0 -20"
    "$mainMod SHIFT, down, resizeactive, 0 20"

    "$mainMod, S, togglespecialworkspace, magic"
    "$mainMod SHIFT, S, movetoworkspace, special:magic"

    "$mainMod, mouse_down, workspace, e+1"
    "$mainMod, mouse_up, workspace, e-1"
  ] ++ config.mods.hyprland.extraBindings;

  # Move/resize windows with mainMod + LMB/RMB and dragging;
  bindm = [
    "$mainMod, mouse:272, movewindow"
    "$mainMod, mouse:273, resizewindow"
  ];

  windowrulev2 = "suppressevent maximize, class:.*";

  windowrule = [
    "float,title:Picture-in-Picture"
  ];

  monitor = monitor;
}

