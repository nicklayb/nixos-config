#!/bin/sh

PROCESS_NAME="wvkbd-mobintl"
COMMAND="wvkbd-mobintl -L 300"

if pgrep -x $PROCESS_NAME > /dev/null; then
  pkill -x $PROCESS_NAME
else
  $COMMAND &
fi
