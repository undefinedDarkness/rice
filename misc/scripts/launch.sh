#!/usr/bin/env bash

# 🚀 Launch Script (RUN WHEN AWESOME STARTS)

fork() { (setsid "$@" &); }

# -- Network Tray Icon --
nm-applet &

# -- Polkit Daemon --
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

# -- Picom --
picom -c &
echo "• Launched nm-applet / picom / polkit"

# -- Keyboard Layout --
# Set the Colemak keyboard layout
# setxkbmap us -variant colemak
setxkbmap us; xmodmap $(realpath $(dirname $0)/xmodmap.colemak) && xset r 66

# Semimak (https://semilin.github.io/semimak/)
# setxkbmap semimak -variant angle
echo "• Changed keyboard layout"

# -- Pulseaudio Fix (Personal) --
sinks=$(pactl list short sinks | awk '{ print $1 " "$2 " " $7 }')
if [[ $(echo "$sinks" | grep -Po '(\S+(?= RUNNING))') == *"Generic_USB_Audio"* ]]
then
	pacmd set-default-sink $(echo "$sinks" | grep '^\d(?=.*SUSPENDED|IDLE)' -Po)
	notify-send "Changed output sink."
	echo "• Changed pulseaudio output sink."
else
	echo "• Did not change pulseaudio output sink."
fi

# -- Set GTK Theme --
gnome=org.gnome.desktop.interface

gsettings set $gnome gtk-theme 'phocus'
gsettings set $gnome icon-theme 'Papirus-Dark'
echo "• Changed GTK / Icon theme"
