#! /bin/sh

BIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$BIN_DIR/base.sh"

declare -a ACTIONS
ACTIONS+=("\U000F0425 Shutdown (PC & NAS)")
ACTIONS+=("\U000F0425 Shutdown")
ACTIONS+=("\U000F0904 Suspend")
ACTIONS+=("\U000F0709 Restart")


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
