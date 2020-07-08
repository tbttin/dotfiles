#!/bin/bash

# Create a temp file.
TMPBG=$(mktemp /tmp/XXXXXXXXXX.png)
LOCK_ICON="$HOME/.config/i3/lock.png"

# Take a screenshot.
scrot -oz $TMPBG

# Simulate oil painting.
convert $TMPBG -paint 3 $TMPBG

# Add the lock icon.
[[ -f $LOCK_ICON ]] && convert $TMPBG $LOCK_ICON -gravity center -composite $TMPBG

# Lock.
i3lock -nuei $TMPBG

# Remove the temp file.
rm $TMPBG
