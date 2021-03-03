#! /bin/sh

if sudo pacman -Syu; then
	dunstify --urgency normal \
		'System Update' 'System update successfully completed'
else
	dunstify --urgency critical \
		'System Update' 'System update failed!'

	read -p 'Press ENTER to continue...'
fi
