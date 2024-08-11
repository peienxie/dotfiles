#!/bin/bash

target_space=""

if [[ "$1" =~ ^[0-9]$ ]]; then
	target_space=$1

elif [ "$1" == "next" ]; then
	target_space=$(yabai -m query --spaces | jq '
	. as $root | map(select(.["has-focus"] == true or (.windows | length > 0)) | .index) as $indices |
	.[] | select(.["has-focus"] == true) | .index as $current_index |
	$indices | index($current_index) as $pos |
	$indices[(($pos + 1) % length)]')
	# don't cycle through spaces
	#if $pos + 1 < length then $indices[$pos + 1] else empty end')

elif [ "$1" == "prev" ]; then
	target_space=$(yabai -m query --spaces | jq '
	. as $root | map(select(.["has-focus"] == true or (.windows | length > 0)) | .index) as $indices |
	.[] | select(.["has-focus"] == true) | .index as $current_index |
	$indices | index($current_index) as $pos |
	$indices[(($pos - 1 + length) % length)]')
	# don't cycle through spaces
	#if $pos > 0 then $indices[$pos - 1] else empty end')

fi

if [ -n "$target_space" ]; then
	yabai -m query --spaces --space "$target_space" | jq -r '.windows[0] // empty' | xargs yabai -m window --focus
fi
