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
inst_pkg playerctl


inst_pip watch-do
inst_pip lemonbar-manager


pushd /tmp
    # Instsall xtmon
    git clone https://github.com/vimist/xtmon

    pushd xtmon
        make
        sudo make install
    popd

    rm -Rf xtmon


    # Install colorpicker
    git clone https://github.com/Jack12816/colorpicker

    pushd colorpicker
        make
        sudo install colorpicker /usr/local/bin
    popd

    rm -Rf xtmon

    # Install dragon
    git clone https://github.com/mwh/dragon

    pushd dragon
        make
        sudo make -n PREFIX=/usr/local install
    popd

    rm -Rf colorpicker
popd
