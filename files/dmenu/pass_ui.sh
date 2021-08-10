#! /bin/bash

BIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

COLOUR='#99AD6A'

source "$BIN_DIR/base.sh"


if [ -n "$1" ]; then
	ENTRY="$1"
else
	ENTRY="$(
		pass find . -type f | \
			grep -Pv '/\.' | \
			sed -e 's/^.\///' -e 's/\// \/ /g' | \
			sort | \
			dmenu -sf "$COLOUR" -p 'Pass:'
	)"

	[ $? -eq 0 ] || exit 1

	ENTRY="${ENTRY// \/ /\/}"
fi

PRETTY_ENTRY="${ENTRY//\// \/ }"

ACTION_PROPERTY="$((
	while read FUNCTION; do
		echo "Run $FUNCTION"
	done < <(pass list-functions "$ENTRY")

	while read PROPERTY; do
		echo "Type $PROPERTY"
	done < <(pass list-properties "$ENTRY")

	echo "View $PRETTY_ENTRY"
	echo "Edit $PRETTY_ENTRY"
) | dmenu -sf "$COLOUR" -p "$PRETTY_ENTRY")"


ACTION="${ACTION_PROPERTY%% *}"
ACTION="${ACTION,,}"
PROPERTY="${ACTION_PROPERTY#* }"

if [ "$ACTION" == 'view' ]; then
	alacritty --hold --command pass get "$ENTRY"
elif [ "$ACTION" == 'edit' ]; then
	alacritty --command pass edit "$ENTRY"
elif [ "$ACTION" == 'run' ]; then
	pass run-function "$ENTRY" "$PROPERTY"
else
	pass "$ACTION-property" "$ENTRY" "$PROPERTY"
fi
