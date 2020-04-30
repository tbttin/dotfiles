#!/bin/bash


icon="$HOME/.config/i3/lock.png"
# Create a temp file.
img=$(mktemp /tmp/XXXXXXXXXX.png)

# Take a screenshot.
scrot -oz $img
#import -window root $img

# Simulate oil painting.
#convert $img -paint 3 $img
# Or pixelate the screenshot.
convert $img -scale 10% -scale 1000% $img

# Add the lock icon.
[[ -f $icon ]] && convert $img $icon -gravity center -composite -matte $img

# Lock
i3lock -nuei $img

# Remove the tmp file.
rm $img
