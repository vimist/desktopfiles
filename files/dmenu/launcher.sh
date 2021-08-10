#! /bin/sh

THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$THIS_DIR/base.sh"
source "$HOME/.bash/functions.sh"


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

case "$ACTION" in
	*Internet*)
		firefox
		;;
	*Mount\ NAS)
		run_in_terminal mount "$HOME/DNAS/Main"
		;;
	*Files*)
		nemo
		;;
	*Mail*)
		geary
		;;
	*Chat*)
		firefox --new-window 'https://messenger.com'
		;;
	*KeePass)
		keepass
		;;
	*Blender)
		blender
		;;
	*NewsBoat)
		run_in_terminal newsboat
		;;
	*Terminal)
		alacritty
		;;
	*Steam)
		steam
		;;
	*Vim)
		run_in_terminal vim
		;;
	*Update)
		run_in_terminal "$HOME/bin/system-update"
		;;
	*Power)
		"$THIS_DIR/power.sh"
		;;
	*)
		$ACTION
		;;
esac
