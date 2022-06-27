#! /bin/sh

THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$THIS_DIR/base.sh"


declare -a ACTIONS
ACTIONS+=("\U000F0239 Internet (Firefox)")
ACTIONS+=("\U000F048D Mount NAS")
ACTIONS+=("\U000F024B Files (Nemo)")
ACTIONS+=("\U000F01EE eMail (Mailspring)")
ACTIONS+=("\U000F0B79 Chat (Messenger)")
ACTIONS+=("\U000F00AB Blender")
ACTIONS+=("\U000F018D Terminal")
ACTIONS+=("\U000F046B RSS (NewsBoat)")
ACTIONS+=("\U000F04D3 Steam")
ACTIONS+=("\U000F01C5 Virt-Manager")
ACTIONS+=("\U000F0171 Vim")
ACTIONS+=("\U000f0162 Update")
ACTIONS+=("\U000f0425 Power")

ACTION="$(
	for ACTION in "${ACTIONS[@]}"; do
		echo -e $ACTION
	done | dmenu -p 'Launch:'
)"


cd "$HOME"
export PATH="$PATH:$HOME/bin"

case "$ACTION" in
	*Internet*)
		exec firefox
		;;
	*Mount\ NAS)
		run-in-terminal "Mount NAS" mount "$HOME/DNAS"
		;;
	*Files*)
		exec nemo
		;;
	*Mail*)
		exec mailspring
		;;
	*Chat*)
		exec firefox --new-window 'https://messenger.com'
		;;
	*Blender)
		exec blender
		;;
	*RSS*)
		run-in-terminal "Newsboat" newsboat
		;;
	*Terminal)
		exec alacritty
		;;
	*Steam)
		exec steam
		;;
	*Virt-Manager)
		exec virt-manager
		;;
	*Vim)
		run-in-terminal Vim vim
		;;
	*Update)
		run-in-terminal "System Update" "$HOME/bin/system-update"
		;;
	*Power)
		exec "$THIS_DIR/power.sh"
		;;
	*)
		exec $ACTION
		;;
esac
