#! /bin/sh

THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$THIS_DIR/base.sh"


declare -a ACTIONS
ACTIONS+=("\uf239 Internet (Firefox)")
ACTIONS+=("\uf48d Mount NAS")
ACTIONS+=("\uf24b Files (Nemo)")
ACTIONS+=("\uf1ee eMail (Mailspring)")
ACTIONS+=("\ufb55 Chat (Messenger)")
ACTIONS+=("\uf0ab Blender")
ACTIONS+=("\uf16c Terminal")
ACTIONS+=("\uf46b RSS (NewsBoat)")
ACTIONS+=("\uf4d3 Steam")
ACTIONS+=("\uf171 Vim")
ACTIONS+=("\uf162 Update")
ACTIONS+=("\uf425 Power")

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
		run_in_terminal "Mount NAS" mount "$HOME/DNAS"
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
		run_in_terminal "Newsboat" newsboat
		;;
	*Terminal)
		exec alacritty
		;;
	*Steam)
		exec steam
		;;
	*Vim)
		run_in_terminal Vim vim
		;;
	*Update)
		run_in_terminal "System Update" "$HOME/bin/system-update"
		;;
	*Power)
		exec "$THIS_DIR/power.sh"
		;;
	*)
		exec $ACTION
		;;
esac
