#! /bin/sh

TITLE="$(xdotool getwindowname $(xdotool getactivewindow))"

BROWSER_SUFFIX='Mozilla Firefox'


autotype() {
	pass run-function "$1" AutoType
}

case "$TITLE" in
	Example*$BROWSER_SUFFIX) autotype 'General/Example' ;;

	*) "$HOME/.config/dmenu/pass_ui.sh" ;;
esac
