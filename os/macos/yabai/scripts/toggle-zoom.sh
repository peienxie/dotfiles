#!/bin/bash

# Reference: https://github.com/koekeishiya/yabai/issues/317#issuecomment-1528727306

function window_is_float {
    layout=$(yabai -m query --spaces --space | jq '.type')
    [ "$layout" = "\"float\"" ] && echo true
    echo $(yabai -m query --windows --window | jq '."is-floating"')
}

float=$(window_is_float)

if $float; then
    cache_dir="/tmp/yabai/zoom_cache"
    mkdir -p $cache_dir
    window_id=$(yabai -m query --windows --window | jq '.id')
    cache_file="$cache_dir/$window_id"


    if [ -e $cache_file ]; then
        window_attributes=$(cat $cache_file)
        x=$(echo $window_attributes | awk '{print $1}')
        y=$(echo $window_attributes | awk '{print $2}')
        w=$(echo $window_attributes | awk '{print $3}')
        h=$(echo $window_attributes | awk '{print $4}')
        yabai -m window --resize abs:$w:$h
        yabai -m window --move abs:$x:$y
        rm -rf $cache_file
    else
        yabai -m query --windows --window | jq '.frame.x, .frame.y, .frame.w, .frame.h' | tr '\n' ' ' > $cache_file
        yabai -m window --grid 1:1:0:0:1:1
    fi

else
    yabai -m window --toggle zoom-fullscreen
fi
