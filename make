#!/bin/sh

# Required Programs
required_programs="nvim bash awesome"

original=$PWD
_start=$(date +%s%3N)
_config=${XDG_CONFIG_HOME:-$_config}
_data=${XDG_DATA_HOME:-$_data}
_to_install=${INSTALL_ONLY:-awesome bash nvim fonts}

ci () {
	case " $_to_install " in
		*" $1 "*) 
			return 0
	esac
	return 1
}

case $1 in

	backup)
		echo "Creating Backup."
		rm -f backup.tar.gz
		touch backup.tar.gz
		tar --exclude-vcs --exclude=backup.tar.gz -pczf backup.tar.gz . 
		echo "Done."
		;;

	clean)
		rm -fr .config Scripts misc/*/ 
		echo "• Cleaned Existing Configurations"
		;;

	rice)

		# Unwrap folders
		wrapped_folders=$(find . -type f -name "*-unwrap.tar.gz")
		for folder in $wrapped_folders; do
			tar -zxf "$folder" $(dirname $folder)
		done

		cp -r ./.config/* "$_config"
		ci "awesome" || rm -r $_config/awesome
		ci "nvim" || rm -r $_config/nvim

		ci "scripts" && cp -r misc/scripts "$HOME/Documents/Scripts"
		ci "fonts" && cp -r misc/fonts "$_data/fonts"
		ci "wallpapers" && cp -r misc/wallpapers "$HOME/Pictures/Wallpapers"
		echo "• Copied Configurations / Wallpapers / Scripts"

		# Firefox
		ci "firefox" && (
			mkdir -p $HOME/.mozilla/firefox/*default-release*/chrome
			cp -r misc/firefox/. $HOME/.mozilla/firefox/*default-release*/chrome/
			echo "• Installed Firefox CSS"
		)

		# Apply patches
		ci "awesome" && (
			cd "$_config/awesome/" || exit
			git clone git@github.com:BlingCorp/bling.git
			cd bling || exit
			git apply "$original/misc/bling-mod.diff"
		)

		# Clone GTK Theme
		ci "gtk" && (
			cd /tmp/ || exit
			git clone https://github.com/phocus/gtk.git
			cd gtk || exit
			git apply "$original/misc/phocus-gtk-mod.diff"
			sudo make install
		)
		echo "• Applied patches to bling and installed gtk theme."

		cat << "EOF"
Post Installation Steps
---------------------------
1. Use misc/discord.css in stylus (https://addons.mozilla.org/en-US/firefox/addon/styl-us/) or discocss (https://github.com/mlvzk/discocss)"
2. Apply misc/*.diff patches for awesome-wm bling (bling patch should be applied already!)"
3. Enable userchrome in firefox (https://www.reddit.com/r/firefox/wiki/userchrome/),
   If that doesnt work you are probably using a different profile, copy the files yourself (from misc/firefox)"
4. Apply the Phocus GTK and the Papirus Icon theme, (Gtk theme should be installed already as `phocus`)
5. If you want, source the misc/scripts/aliases.sh file 
EOF
		echo "Finished in $(( $(date +%s%3N) - _start ))ms"
		;;

	pull)

		sh "$0" clean

		mkdir -p .config

		# Awesome Config
		cp -r $_config/awesome ./.config 
		
		# Store bling modifications
		(
			cd ./.config/awesome/bling || exit
			git diff > "$original/misc/bling-mod.diff"
			rm -rf ./.config/awesome/bling
		)

		# Other applications
		# cp -rfL $_config/rofi ./.config 2> /dev/null
		# cp -rfL $_config/wezterm ./.config 2> /dev/null
		# cp -fL $_config/picom.conf ./.config 2> /dev/null

		# Firefox CSS
		# mkdir -p misc/firefox
		# cp -r $HOME/.mozilla/firefox/*default-release*/chrome/. misc/firefox

		# Neovim
		mkdir -p ./.config/nvim
		cp -fL $_config/nvim/* ./.config/nvim 2> /dev/null
		cp -rfL $_config/nvim/lua ./.config/nvim 2> /dev/null

		# GTK Theme
		# (
		# 	cd "$HOME/Downloads/phocus-gtk" || return
		# 	git diff > "$original/misc/phocus-gtk-mod.diff"
		# )

		# Copy Other
		# cp -rfL $HOME/Documents/Scripts ./misc/scripts 2> /dev/null
		cp -rfL $_data/fonts ./misc 2> /dev/null
		# cp -rfL $HOME/Pictures/Wallpapers ./misc/wallpapers 2> /dev/null
		echo "• Copied Scripts / Wallpapers / Fonts"

		# Delete empty folders
		find . -type d -empty -not -path "*/\.git/*" -not -name '.git' -delete &
	
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

