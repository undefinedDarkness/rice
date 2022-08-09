#!/bin/bash
S="
"

ui=$( dmenu -X 750 -Y 450 -W 100 -l 3 <<< "Poweroff${S}Restart${S}Logout" )

case "$ui" in
	"Poweroff")
		systemctl poweroff
		;;
	"Restart")
		systemctl reboot
		;;
	"Logout")
		;;
esac
