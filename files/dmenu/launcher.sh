#! /bin/sh

THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$THIS_DIR/base.sh"
source "$HOME/.bash/functions.sh"


declare -a ACTIONS
ACTIONS[0]="\uf239 Internet (Firefox)"
ACTIONS[1]="\uf48d Mount NAS"
ACTIONS[2]="\uf24b Files (Nemo)"
ACTIONS[3]="\uf1ee eMail (Geary)"
ACTIONS[4]="\ufb55 Chat (Messenger)"
ACTIONS[5]="\uf0ab Blender"
ACTIONS[6]="\uf16c Terminal"
ACTIONS[6]="\uf4d3 Steam"
ACTIONS[7]="\uf171 Vim"
ACTIONS[9]="\uf162 Update"
ACTIONS[10]="\uf425 Power"

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
		run_in_terminal "$HOME/bin/system_update.sh"
		;;
	*Power)
		"$THIS_DIR/power.sh"
		;;
	*)
		$ACTION
		;;
esac
