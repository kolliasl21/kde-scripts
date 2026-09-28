switch_virtual_keyboard() {
	local i target_string="InputMethod" temp
	local string_length="${#target_string}"
	declare -a ascii_array

	for ((i=0; i<string_length; i++)); do
		printf -v temp "%d" "'${target_string:$i:1}"
		ascii_array+=("$temp")
	done

	echo "Starting $1"

	kwriteconfig6 --file kwinrc \
		--group Wayland \
		--key InputMethod \
		"/usr/share/applications/$1"

	busctl --user emit /kwinrc org.kde.kconfig.notify \
		ConfigChanged "a{saay}" 1 Wayland 1 \
		"$string_length" \
		"${ascii_array[@]}"
}

_input_method_func() {
	busctl --user call org.kde.KWin \
		/VirtualKeyboard \
		org.freedesktop.DBus.Properties \
		Set "ssv" "org.kde.kwin.VirtualKeyboard" "mode" i "$1"
}

display_osd_message() {
	busctl --user call org.kde.plasmashell \
		/org/kde/osdService \
		org.kde.osdService \
		virtualKeyboardEnabledChanged "b" "$1"
}

switch_input_method() {
	case "$1" in
		0) _input_method_func "$1";;
		1) _input_method_func "$1";;
		2) _input_method_func "$1";;
		*) echo "Wrong option: Available options (0,1,2)";;
	esac
}
