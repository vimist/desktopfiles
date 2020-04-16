dmenu() {
	command dmenu \
		-l 10 \
		-i \
		-fn 'Noto Sans Display,Noto Sans Disp ExtLt,Material Design Icons' \
		-nb '#111111' \
		-nf '#888888' \
		-sb '#333333' \
		-sf '#D8AD4C' \
		"$@"
}
