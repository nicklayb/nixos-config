#!/usr/bin/env sh

QUERY=$1
DESTINATION=$2

API_URL="http://hal.nboisvert.local:7070/photos/random"

RAW_URL=$(curl -G -H "Accept: application/json" --data-urlencode="orientation=landscape" --data-urlencode="query=$QUERY" -s "$API_URL" | jq -r '.urls.raw')

if [ -z "$RAW_URL" ] || [ "$RAW_URL" = "null" ]; then
  echo "Invalid URL"
  exit 1
fi

curl -L "$RAW_URL" -o "$DESTINATION"

systemctl restart hyprpaper --user
