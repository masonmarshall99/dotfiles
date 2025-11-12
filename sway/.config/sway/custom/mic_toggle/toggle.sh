#!/bin/sh

pactl set-source-mute @DEFAULT_SOURCE@ toggle

muted="$(pactl get-source-mute @DEFAULT_SOURCE@)"

if [[ "$muted" == "Mute: yes" ]]; then
	play -v 0.1 ~/.config/sway/custom/mic_toggle/mute_sfx.ogg
else
	play -v 0.1 ~/.config/sway/custom/mic_toggle/unmute_sfx.ogg
fi
