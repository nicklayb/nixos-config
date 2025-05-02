#!/bin/sh

# 1. Mount SD card using `nautilus`
# 2. Run this script

SERVER=hal.nboisvert.local
CARD_A="3061-3038"
CARD_B="4A21-0000"

if [ -d "/run/media/$USER/$CARD_A" ]; then
  SD_CARD="/run/media/$USER/$CARD_A"
  CARD=$CARD_A
fi

if [ -d "/run/media/$USER/$CARD_B" ]; then
  SD_CARD="/run/media/$USER/$CARD_B"
  CARD=$CARD_B
fi

if [ -z $SD_CARD ]; then
  echo "SD Cards not connected";
  exit -1;
fi

SD_PHOTO_FOLDER="$SD_CARD/DCIM"
PHOTO_DESTINATION_FOLDER=/mnt/raid/photos
PHOTO_DESTINATION=$USER@$SERVER:$PHOTO_DESTINATION_FOLDER

echo "Synchronizing SD Card photos to $PHOTO_DESTINATION"

rsync -rav "$SD_PHOTO_FOLDER/" $PHOTO_DESTINATION

SD_VIDEO_FOLDER="$SD_CARD/PRIVATE/M4ROOT/CLIP"
VIDEO_DESTINATION_FOLDER=/mnt/raid/videos/$CARD
VIDEO_DESTINATION=$USER@$SERVER:$VIDEO_DESTINATION_FOLDER

echo "Synchronizing SD Card videos to $VIDEO_DESTINATION"

rsync -rav "$SD_VIDEO_FOLDER/" $VIDEO_DESTINATION
