dmenu() {
	command dmenu \
		-l 10 \
		-i \
		-fn 'JetBrains Mono,Material Design Icons Desktop:size=10.5' \
		-nb '#111111' \
		-nf '#888888' \
		-sb '#333333' \
		-sf '#D8AD4C' \
		"$@"
}
