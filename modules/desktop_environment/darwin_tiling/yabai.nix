{ config }:
{
  focus_follows_mouse = "autofocus";
  layout = "bsp";
  split_ratio = 0.5;
  auto_balance = "off";
  top_padding = config.gaps;
  bottom_padding = config.gaps;
  left_padding = config.gaps;
  right_padding = config.gaps;
  window_gap = config.gaps;
  window_placement = "second_child";
}
