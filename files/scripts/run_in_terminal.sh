#! /bin/sh

TITLE="$1"

shift

alacritty --title "$TITLE" --command "$@"
