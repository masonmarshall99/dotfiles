#!/bin/sh

wpctl set-mute @DEFAULT_SOURCE@ toggle

muted="$(wpctl get-volume @DEFAULT_SOURCE@)"

if [[ "$muted" == *"MUTED"* ]]; then
	play -v 0.1 ~/.config/sway/custom/mic_toggle/mute_sfx.ogg
else
	play -v 0.1 ~/.config/sway/custom/mic_toggle/unmute_sfx.ogg
fi
