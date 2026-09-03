#!/usr/bin/env sh

QUERY=$1
DESTINATION=$2
CLIENT=$3

API_URL="http://proxy-cat.k8s.home.arpa/photos/random"

RAW_URL=$(curl -G -H "X-ProxyCat-Target: unsplash" -H "Accept: application/json" --data-urlencode="orientation=landscape" --data-urlencode="query=$QUERY" --data-urlencode="_c=$(echo -n $DESTINATION | shasum)" -s "$API_URL" | jq -r '.urls.raw')

if [ -z "$RAW_URL" ] || [ "$RAW_URL" = "null" ]; then
  echo "Invalid URL"
  exit 1
fi

curl -L "$RAW_URL" -o "$DESTINATION"

