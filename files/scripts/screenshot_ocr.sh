#! /bin/sh

scrot -s -l mode=edge -q 100 -o /tmp/ocr.png
tesseract /tmp/ocr.png /tmp/ocr
xclip -selection clipboard -target text/plain /tmp/ocr.txt

dunstify 'Text copied:' "$(cat /tmp/ocr.txt)"
