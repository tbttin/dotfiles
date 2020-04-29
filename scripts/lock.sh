#!/bin/bash


# Take a screenshot.
scrot -zo /tmp/screen.png

# Simulate oil painting.
convert /tmp/screen.png -paint 3 /tmp/screen.png
# Center lock image.
[[ -f ~/.config/i3/lock-256.png ]] && convert /tmp/screen.png ~/.config/i3/lock-256.png -gravity center -composite -matte /tmp/screen.png

# Lock
i3lock -nuei /tmp/screen.png

# Remove
rm /tmp/screen.png
