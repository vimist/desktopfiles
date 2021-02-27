#! /bin/sh

WID="$1"
CLASS="$2"
INSTANCE="$3"
TITLE="$(xtitle "$WID")"


if [[ "$CLASS" = "Blender" && "$TITLE" = "Blender Preferences" ]]; then
	echo 'state=floating center'
elif [[ "$CLASS" = "Steam" && "$TITLE" != "Steam" ]]; then
	echo 'state=floating center'
elif [[ "$CLASS" = "feh" ]]; then
	echo 'state=pseudo_tiled center'
elif [[ "$CLASS" = "mpv" ]]; then
	echo 'state=pseudo_tiled center'
fi

# Debug - `tail -f /tmp/bspwm_rules_script`
# echo "$WID, $CLASS, $INSTANCE, $TITLE" >> /tmp/bspwm_rules_script
