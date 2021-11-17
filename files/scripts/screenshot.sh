#! /bin/sh

scrot -s -o /tmp/screenshot.png
xclip -selection clipboard -target image/png /tmp/screenshot.png
dunstify 'Screenshot' "Saved in '/tmp/screenshot.png' and copied to the clipboard"
