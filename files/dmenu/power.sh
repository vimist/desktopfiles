#! /bin/sh

BIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$BIN_DIR/base.sh"

declare -a ACTIONS
ACTIONS[0]="\uf425 Shutdown"
ACTIONS[1]="\uf903 Suspend"
ACTIONS[4]="\uf708 Restart"


ACTION=$(
	for ACTION in "${ACTIONS[@]}"; do
		echo -e $ACTION
	done | dmenu -p 'Power:'
)


case "$ACTION" in
	*Shutdown)
		shutdown now
		;;
	*Suspend)
		systemctl suspend
		;;
	*Logout)
		bspc quit
		;;
	*Restart)
		reboot
		;;
esac
