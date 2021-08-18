#!/usr/bin/env sh

# Setup Colemak
case $1 in
	launch)
		#setxkbmap us
		xmodmap $( dirname $0 )/xmodmap.colemak && xset r 66
		picom -c -C --blur-method kernel --blur-background
		exit
		;;
esac

# -- ALIASES & SETUP -- 

alias vim=nvim
alias clojure="XDG_CONFIG_HOME=\$HOME/.config clojure"
alias wget="wget --hsts-file /dev/null"
alias gitFixup="git commit --fixup=HEAD"
alias fileSize="du -sh "
alias screenshot='import -window $(xwininfo | grep -Eom1 "0x[0-9]+") -frame -border ~/screenshot.png'

# Enable Auto Directory Change
case $SHELL in
	*bash) 
		shopt -s autocd
esac

export LESSHISTFILE=- # Disable Less History
export PATH="$PATH:$HOME/.local/bin" # Path
export PS1="\[\e[36m\]\w\[\e[m\] \[\e[32m\]->\[\e[m\] " # Prompt

case "$(uname -r)" in
	*microsoft-standard-WSL2)

		# For WSL (Windows Subsystem For Linux)
		export DISPLAY="$(grep nameserver /etc/resolv.conf | sed 's/nameserver //'):0"
		export DISPLAY="$(sed -n 's/nameserver //p' /etc/resolv.conf):0"
		export DISPLAY=$(ip route|awk '/^default/{print $3}'):0.0

		# Set Config Directory To Dotfiles
		export XDG_CONFIG_HOME=$HOME/rice/.config
		;;

esac

# -- FUNCTIONS --

github_ssh_setup () {
	printf "Email: "
	read -r email
	
	echo "Generate SSH Key..."
	ssh-keygen -t ed25519 -C "$email"

	echo "Starting ssh-agent & adding key"
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_ed25519

	echo "Copy paste the following to github:"
	cat ~/.ssh/id_ed25519.pub
}


# Symlink Files
symlink () {
	ln -s "$(realpath $1)" "$(realpath $2)"
}

# Search In Files
ack () {
	grep -rs --color=always "$1" "${2:-.}"
}

# Compress File / Folder
compress () {
	tar_f=$(mktemp)
	if [ -d "$1" ]; then
		tar -cf "$tar_f" "$1"
	else
		tar_f=$1
	fi
	zstd -22 --ultra -T0 -z "$tar_f" -o "$(basename "$1").tar.zst"
}

