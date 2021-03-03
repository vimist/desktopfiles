#! /bin/sh

COLOUR="$(colorpicker --one-shot --preview)"
COLOUR="${COLOUR##*: }"
echo -n "$COLOUR" | xclip -selection clipboard
dunstify "Colour Picker" "$COLOUR"
