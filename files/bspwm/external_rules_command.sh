#! /bin/sh

WID="$1"
CLASS="$2"
INSTANCE="$3"
TITLE="$(xtitle "$WID")"


if [[ "$CLASS" = "Blender" && "$TITLE" = "Blender Preferences" ]]; then
	echo 'state=floating center=on'
elif [[ "$CLASS" = "Steam" && "$TITLE" != "Steam" ]]; then
	echo 'state=floating center=on'
elif [[ "$CLASS" = "feh" ]]; then
	echo 'state=pseudo_tiled center=on'
elif [[ "$CLASS" = "mpv" ]]; then
	echo 'state=pseudo_tiled center=on'
elif [[ "$CLASS" = "Alacritty" && "$TITLE" = "Mount NAS" ]]; then
	echo 'state=floating rectangle=500x100+0+0 center=on'
elif [[ "$CLASS" = "Alacritty" && "$TITLE" = "Calculator" ]]; then
	echo 'state=floating rectangle=300x400+0+0 center=on'
fi

# Debug - `tail -f /tmp/bspwm_rules_script`
# echo "$WID, $CLASS, $INSTANCE, $TITLE" >> /tmp/bspwm_rules_script
