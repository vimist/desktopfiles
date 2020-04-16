#! /bin/sh

WID="$1"
CLASS="$2"
INSTANCE="$3"
TITLE="$(xtitle "$WID")"


if [[ "$CLASS" = "Blender" && "$TITLE" = "Blender Preferences" ]]; then
	echo 'state=floating center'
fi

# Debug - `tail -f /tmp/bspwm_rules_script`
#echo "$WID, $CLASS, $INSTANCE, $TITLE" >> /tmp/bspwm_rules_script
