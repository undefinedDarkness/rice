#!/usr/bin/env bash

# Launch Nm-Applet
nm-applet &

# Colemak
setxkbmap us -variant colemak

# Picom
picom -c --experimental-backends --backend glx &
