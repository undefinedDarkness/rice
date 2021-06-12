#!/usr/bin/env bash

p="$HOME/Pictures/Screenshots/$(date +"%d-%m-%y %M").png"
c=$(echo -en "Window\0icon\x1fappointment-new\nSelection\0icon\x1fimage-crop\nScreen\0icon\x1fvideo-display\n" | rofi -dmenu -theme screenshot -p "")

case $c in
  "Window")
    import -window $(xwininfo | grep -Po "Window id: \K\w+") $p
    ;;
  "Selection")
    import $p
    ;;
  "Screen")
    import -window root $p
    ;;
  *)
    exit
    ;;
esac
