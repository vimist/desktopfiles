#! /bin/sh

TMP_FILE='/tmp/screenanim.mp4'
OUT_FILE='/tmp/screenanim.gif'
PID_FILE='/tmp/screenanim.pid'


if [ -f "$PID_FILE" ]; then
	# Kill the recording process and wait for it to finish
	kill "$(cat "$PID_FILE")"
	tail --pid "$(head --lines 1 "$PID_FILE")" --follow /dev/null

	# Wait for the conversion process to start and then wait for it to complete
	sleep 0.1
	tail --pid "$(tail --lines 1 "$PID_FILE")" --follow /dev/null

	rm "$PID_FILE"

	# The target image/gif doesn't seem to work properly with xclip, so we're
	# forced to use an incorrect mime type. It wouldn't work otherwise, so worst
	# case scenario is that it still doesn't work.
	xclip -selection clipboard -target image/png "$OUT_FILE"
	dunstify 'Animation' "Saved in '$OUT_FILE' and copied to the clipboard"
else
	# We should be able to do this in one command, but it appears as though
	# ffmpeg doesn't output anything if we forcibly stop recording a gif,
	# whereas forcibly stopping an mp4 doesn't seem to affect anything.

	# Record the animation as an mp4 (see above)
	ffmpeg -y \
		-f x11grab \
		-select_region 1 \
		-show_region 1 \
		-i :0.0 \
		-f mp4 \
		"$TMP_FILE" &

	echo "$!" > "$PID_FILE"
	wait

	# Convert the mp4 toa gif
	ffmpeg -y \
		-f mp4 \
		-i "$TMP_FILE" \
		-filter_complex 'fps=10, split[a][b]; [a]palettegen[p]; [b][p]paletteuse' \
		-final_delay 200 \
		"$OUT_FILE" &

	echo "$!" >> "$PID_FILE"
	wait
fi
