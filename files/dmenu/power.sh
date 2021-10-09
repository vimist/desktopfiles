#! /bin/sh

BIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$BIN_DIR/base.sh"

declare -a ACTIONS
ACTIONS+=("\uf425 Shutdown (PC & NAS)")
ACTIONS+=("\uf425 Shutdown")
ACTIONS+=("\uf903 Suspend")
ACTIONS+=("\uf708 Restart")


ACTION=$(
	for ACTION in "${ACTIONS[@]}"; do
		echo -e $ACTION
	done | dmenu -p 'Power:'
)


case "$ACTION" in
	*Shutdown*NAS*)
		shutdown-nas
		;&
	*Shutdown)
		exec systemctl poweroff
		;;
	*Suspend)
		exec systemctl suspend
		;;
	*Restart)
		exec systemctl reboot
		;;
esac
