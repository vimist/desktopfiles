#! /usr/bin/env bash

# Ensure we're working from this directory
cd "$(dirname $0)"

# The link function will append this to any files that already
# exist in order to preserve them
backup_suffix='.orig'

# Link a file from this repository into the users home directory
# backups of existing files will be made with a suffix of $backup_suffix
# $1 The source file, relative to the current directory
# $2 The destination file, relative to $HOME/.config
#    $1 is used if $2 is not specified, this allows us to pass in a single
#    argument if $1 should be recreated under $HOME
function link() {
    default_dst="$(basename "$PWD")/$1"

    src="$PWD/$1"
    dst="$HOME/.config/${2:-$default_dst}"

    mkdir -p "$(dirname "$dst")"

    # If the destination is a symlink
    if [[ -L "$dst" ]]; then
        rm "$dst"
        echo "Removed existing symlink '$dst'"
    fi

    ln --symbolic --backup --suffix "$backup_suffix" "$src" "$dst"
    echo "Installed '$dst'"
}

# Redirect the output so we don't clutter the screen
function pushd() {
    command pushd "$1" > /dev/null
}

# Redirect the output so we don't clutter the screen
function popd() {
    command popd > /dev/null
}

# Start linking files

# General files
pushd files
link bg.jpg bg.jpg
popd

# BSPWM
pushd files/bspwm
link bspwmrc
link external_rules_command.sh
popd

# SXHKD
pushd files/sxhkd
link sxhkdrc
popd

# Lemonbar
pushd files/lemonbar
link bar.py
link modules.py
link bspwm_modules.py
link clock_modules.py
link disk_modules.py
link sound_modules.py
link task_modules.py
popd

# dmenu
pushd files/dmenu
link base.sh
link launcher.sh
link power.sh
link pass_ui.sh
popd

# Dunst
pushd files/dunst
link dunstrc
popd

# feh
pushd files/feh
link themes
popd

# Scripts
pushd files/scripts
link window_autotype.sh
link system_update.sh
popd

echo
echo "Done!"
echo "Any existing files have been renamed with a suffix of '$backup_suffix'"
