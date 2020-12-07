#!/usr/bin/env sh

killall -q dunst

# Wait until the processes have been shut down
while pgrep -u $UID -x dunst >/dev/null; do sleep 1; done

feh --bg-scale ~/img/wallpaper.png
dunst -config $HOME/.config/dunst/dunstrc
