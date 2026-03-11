{
  config,
  lib,
  username,
  ...
}:
{
  options = {
    mods.darwin_tiling = {
      sketchybar = {
        enable = lib.mkEnableOption "Enables sketchybar";
      };
    };
  };
  config =
    let
      sketchybar = config.mods.darwin_tiling.sketchybar;
      sketchybarTheme = import ./sketchybar/theme.nix { config = sketchybar; };
      colors = sketchybarTheme.colors;
      style = sketchybarTheme.style;
    in
    lib.mkIf sketchybar.enable {
      services.sketchybar = {
        enable = true;
        config = ''
          sketchybar --bar height=30 \
            color="${colors.bar_color}" \
            shadow="${style.shadow}" \
            position=top \
            sticky=on \
            padding_right=0 \
            padding_left=3 \
            corner_radius="${style.corner_radius}" \
            y_offset=5 \
            margin=5 \
            blur_radius=20 \
            notch_width=200 \
            --default updates=when_shown \
            icon.font="${style.font}:Bold:13.5" \
            icon.color="${colors.white}" \
            icon.padding_left="${style.paddings}" \
            icon.padding_right="${style.paddings}" \
            label.font="${style.font}:Bold:13.0" \
            label.color="${colors.white}" \
            label.padding_left="${style.paddings}" \
            label.padding_right="${style.paddings}"

          SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")

          sketchybar --add item spacer.1 left \
            --set spacer.1 background.drawing=off \
            label.drawing=off \
            icon.drawing=off \
            width=10

          for i in {0..9}; do
            sid=$((i + 1))
            sketchybar --add space space.$sid left \
            	--set space.$sid associated_space=$sid \
            	label.drawing=off \
            	icon.padding_left=10 \
            	icon.padding_right=10 \
            	background.padding_left=-5 \
            	background.padding_right=-5 \
            	script="$HOME/.config/sketchybar/plugins/spaces.sh"
          done

          sketchybar --add item spacer.2 left \
            --set spacer.2 background.drawing=off \
            label.drawing=off \
            icon.drawing=off \
            width=5

          sketchybar --add bracket spaces '/space.*/' \
            --set spaces background.border_width="${style.border_width}" \
            background.border_color="${colors.red}" \
            background.corner_radius="${style.corner_radius}" \
            background.color="${colors.bar_color}" \
            background.height=26 \
            background.drawing=on

          sketchybar --add item separator left \
            --set separator icon= \
            icon.font="${style.font}:Regular:16.0" \
            background.padding_left=26 \
            background.padding_right=15 \
            label.drawing=off \
            associated_display=active \
            icon.color="${colors.yellow}"
        '';
      };

      system.defaults.NSGlobalDomain._HIHideMenuBar = true;

      home-manager.users.${username} = {
        home.file.".config/sketchybar/plugins/spaces.sh" = {
          text = import ./sketchybar/plugins/spaces.nix { theme = sketchybarTheme; };
          executable = true;
        };
      };
    };
}
