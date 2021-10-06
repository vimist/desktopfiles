#! /bin/sh

# Ensure we're working from this directory
cd "$(dirname $0)"

# Output colours
error() { tput setaf 1; echo "$@"; tput sgr0; }
warn() { tput setaf 3; echo "$@"; tput sgr0; }
success() { tput setaf 2; echo "$@"; tput sgr0; }

# Link a file from $1 to $2 with some nice checks
# $1 The source file, relative to the current directory
# $2 The destination file
#    If unspecified, the basename of the current directory will be appended to
#    "$HOME/.config" and the file will be linked there.
#    If the destination is specified then it will be used.
link() {
    default_dst="$HOME/.config/$(basename "$PWD")/$1"

    src="$PWD/$1"
    dst="${2:-$default_dst}"

    # Check source exists
    if [[ ! -e "$src" ]]; then
        error "Source file '$src' does not exist"
        return
    fi

    mkdir -p "$(dirname "$dst")"

    # If the destination exists
    if [[ -e "$dst" || -L "$dst" ]]; then
        warn -n "Removing existing file '$dst'... "
        if rm "$dst"; then
            success Done
        else
            error Failed
            return
        fi
    fi

    if ln --symbolic "$src" "$dst"; then
        success "Installed '$src'"
    else
        error "Could not symlink '$src'"
    fi
}

# Redirect the output so we don't clutter the screen
pushd() { command pushd "$1" > /dev/null; }
popd() { command popd > /dev/null; }


# Start linking files

# General files
pushd files
link bg.jpg "$HOME/.config/bg.jpg"
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
link media_modules.py
popd

# Dmenu
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

# Feh
pushd files/feh
link themes
popd

# Scripts
pushd files/scripts
link window_autotype.sh "$HOME/bin/window-autotype"
link system_update.sh "$HOME/bin/system-update"
link shutdown_nas.sh "$HOME/bin/shutdown-nas"
link open_url.sh "$HOME/bin/open-url"
link screenshot.sh "$HOME/bin/screenshot"
link colour_picker.sh "$HOME/bin/colour-picker"
link run_in_terminal.sh "$HOME/bin/run-in-terminal"
popd

# Newsboat
pushd files/newsboat
link config "$HOME/.config/newsboat/config"
link urls "$HOME/.config/newsboat/urls"
link colours "$HOME/.config/newsboat/colours"
link key_bindings "$HOME/.config/newsboat/key_bindings"
popd

echo
echo "Done!"
