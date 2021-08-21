#!/bin/sh

# Lua Formatter To Use:
#lua_formatter=luafmt --use-tabs -w replace {}
lua_formatter='stylua {}'

# Original BashRC Location:
original_bashrc="/etc/skel/.bashrc"

# Required Programs
required_programs="xwininfo rofi nvim firefox bash awesome picom nm-applet /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 pacmd notify-send xclip"

original=$PWD
_start=$(date +%s%3N)

case $1 in

	backup)
		echo "Creating Backup."
		rm -f backup.tar.gz
		touch backup.tar.gz
		tar --exclude-vcs --exclude=backup.tar.gz -pczf backup.tar.gz . 
		echo "Done."
		;;

	clean)
		rm -fr .config Scripts misc/*/ Wallpapers
		echo "• Cleaned Existing Configurations"
		;;

	rice)
		cp -r ./.config/* "$HOME/.config"
		cp -r misc/scripts ~/Documents/Scripts
		cp -r misc/fonts ~/.local/share/fonts
		cp -r misc/wallpapers ~/Pictures/Wallpapers
		echo "• Copied Configurations / Wallpapers / Scripts"

		# Firefox
		mkdir -p ~/.mozilla/firefox/*default-release*/chrome
		cp -r misc/firefox/. ~/.mozilla/firefox/*default-release*/chrome/
		echo "• Installed Firefox CSS"

		# Apply patches
		(
			cd "$HOME/.config/awesome/" || exit
			git clone git@github.com:BlingCorp/bling.git
			cd bling || exit
			git apply "$original/misc/bling-mod.diff"
		)
		# (
		# 	patch "$HOME/.bashrc" "$original/misc/bashrc-mod.diff"
		# )
		(
			cd /tmp/ || exit
			git clone git@github.com:phocus/gtk.git
			cd gtk || exit
			git apply "$original/misc/phocus-gtk-mod.diff"
			sudo make install
		)
		echo "• Applied patches to bling and installed gtk theme."

		cat << "EOF"
Post Installation Steps
---------------------------
1. Use misc/discord.css in stylus (https://addons.mozilla.org/en-US/firefox/addon/styl-us/) or discocss (https://github.com/mlvzk/discocss)"
2. Apply misc/*.diff patches for bashrc and awesome-wm bling (bling patch should be applied already!)"
3. Enable userchrome in firefox (https://www.reddit.com/r/firefox/wiki/userchrome/),
   If that doesnt work you are probably using a different profile, copy the files yourself (from misc/firefox)"
4. Apply the Phocus GTK and the Papirus Icon theme, (Gtk theme should be installed already as `phocus`)
EOF
		echo "Finished in $(( $(date +%s%3N) - _start ))ms"
		;;

	pull)

		sh "$0" clean

		mkdir -p .config

		# Awesome Config
		cp -r ~/.config/awesome ./.config 
		
		# Store bling modifications
		(
			cd ./.config/awesome/bling || exit
			git diff > "$original/misc/bling-mod.diff"
			rm -rf ./.config/awesome/bling
		)

		# Other applications
		cp -rfL ~/.config/rofi ./.config 2> /dev/null
		cp -rfL ~/.config/wezterm ./.config 2> /dev/null
		cp -fL ~/.config/picom.conf ./.config 2> /dev/null

		# Firefox CSS
		mkdir -p misc/firefox
		cp -r ~/.mozilla/firefox/*default-release*/chrome/. misc/firefox

		# Neovim
		mkdir -p ./.config/nvim
		cp -fL ~/.config/nvim/* ./.config/nvim 2> /dev/null
		cp -rfL ~/.config/nvim/lua ./.config/nvim 2> /dev/null

		# Bash Config
		diff "$original_bashrc" "$HOME/.bashrc" > misc/bashrc-mod.diff
		echo "• Copied Application Configurations"

		# GTK Theme
		(
			cd "$HOME/Downloads/phocus-gtk" || return
			git diff > "$original/misc/phocus-gtk-mod.diff"
		)

		# Copy Other
		cp -rfL ~/Documents/Scripts ./misc/scripts 2> /dev/null
		cp -rfL ~/.local/share/fonts ./misc 2> /dev/null
		cp -rfL ~/Pictures/Wallpapers ./misc/wallpapers 2> /dev/null
		echo "• Copied Scripts / Wallpapers / Fonts"

		# Delete empty folders
		find . -type d -empty -not -path "*/\.git/*" -delete &

		# Format files -- MAYBE REMOVE
		find . -type f -name "*.lua" -not -path "./.config/awesome/bling/*" -exec $lua_formatter \; &
		echo "• Formatted Files & Trimmed Directories"

		printf "\n\e[1mTODO:\e[0m Copy Discord CSS From Stylus\n"
		printf "\e[1mTODO:\e[0m Update README (if required)\n"
		echo "Finished in $(( $(date +%s%3N) - _start ))ms"
		;;
	*)
		cat << "EOF"
             ;,'
     _o_    ;:;'
 ,-.'---`.__ ;
((j`=====',-'
 `-\     /
    `-=-'     

🍲 Pre Installation Steps
-------------------------
To proceed, kindly backup all your personal configurations
as I cannot guarentee my script won't overrite them :')
Then run `./make rice`

To make the entire rice function correctly you will the following programs installed and functional.
EOF
		for prog in $required_programs
		do
			if ! command -v "$prog" 1> /dev/null
			then
				printf '%s \e[31m✗\e[0m\n' "$prog"
			else
				printf '%s \e[32m✔\e[0m\n' "$prog"
			fi
		done
		;;
esac

