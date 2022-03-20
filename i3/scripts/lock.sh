#!/usr/bin/env bash

# ref: https://www.reddit.com/r/i3wm/comments/5w95fp/how_to_get_lockscreen_like_this/

lockimg="$HOME/.config/i3/scripts/screen-lock.png"
tmpimg="/tmp/lockscreen.png"

# xfce4-screenshooter -f --save $tmpimg
# -o option allow scrot to overwrite existed file
scrot -o "$tmpimg"
convert "$tmpimg" -scale 10% -scale 1000% "$tmpimg"

if [[ -f $lockimg ]]
then
    # placement x/y
    PX=0
    PY=0
    # lockscreen image info
    R=$(file $lockimg | grep -o '[0-9]* x [0-9]*')
    RX=$(echo $R | cut -d' ' -f 1)
    RY=$(echo $R | cut -d' ' -f 3)
 
    SR=$(xrandr --query | grep ' connected' | sed 's/primary //' | cut -f3 -d' ')
    for RES in $SR
    do
      echo res: $RES
        # monitor position/offset
        SRX=$(echo $RES | cut -d'x' -f 1)                   # x pos
        SRY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 1)  # y pos
        SROX=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 2) # x offset
        SROY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 3) # y offset
        PX=$(($SROX + $SRX/2 - $RX/2))
        PY=$(($SROY + $SRY/2 - $RY/2))
        convert "$tmpimg" "$lockimg" -geometry +$PX+$PY -composite -matte "$tmpimg"
    done
fi 

i3lock -e -u -n -i $tmpimg
