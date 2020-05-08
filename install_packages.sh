PS4="$(tput setab 3)  $(tput sgr0) "
set -x -e


function inst_pkg() { sudo pacman -S "$@"; }
function inst_pip() { sudo pip3 install "$@"; }


inst_pkg bspwm
inst_pkg sxhkd
inst_pkg lemonbar
inst_pkg dmenu
inst_pkg feh
inst_pkg xdo
inst_pkg alacritty
inst_pkg ncdu      # Disk usage analyser
inst_pkg scrot


inst_pip git+https://github.com/vimist/watch-do


# Instsall xtmon
pushd /tmp
	git clone https://github.com/vimist/xtmon

	pushd xtmon
		make
		sudo make install
	popd

	rm -Rf xtmon
popd
