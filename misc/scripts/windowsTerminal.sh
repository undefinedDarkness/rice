#!/bin/sh

location='/mnt/c/Users/David Noronha/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json'
if [ "$1" = "on" ]; then
	# Change colorscheme as required.
	sed -i -e 's!"colorScheme": "rose-pine"!"colorScheme": "plain"!g' \
		   -e 's!"face": "Iosevka Term"!"face": "Courier New"!g' "$location"
else
	sed -i -e 's!"colorScheme": "plain"!"colorScheme": "rose-pine"!g' \
		   -e 's!"face": "Courier New"!"face": "Iosevka Term"!g' "$location"
fi
