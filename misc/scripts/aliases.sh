#!/usr/bin/env bash

# -- ALIASES & SETUP -- 

alias vim=nvim

# Enable Auto Directory Change (BASH ONLY)
shopt -s autocd

case "$(uname -r)" in

	*microsoft-standard-WSL2)
		# >&2 echo "Running WSL Specific Code."

		# For WSL (Windows Subsystem For Linux)
		export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"
		export DISPLAY="`sed -n 's/nameserver //p' /etc/resolv.conf`:0"
		export DISPLAY=$(ip route|awk '/^default/{print $3}'):0.0

		# Set Config Directory To Dotfiles
		export XDG_CONFIG_HOME=$HOME/rice/.config
		;;

esac

export PATH="$PATH:$HOME/.local/bin:/usr/local/go/bin:$HOME/go/bin"

# -- FUNCTIONS --

github-ssh-setup () {
	printf "Email: "
	read email
	
	echo "Generate SSH Key..."
	ssh-keygen -t ed25519 -C "$email"

	echo "Starting ssh-agent & adding key"
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_ed25519

	echo "Copy paste the following to github:"
	cat ~/.ssh/id_ed25519.pub
}

git () {
	case $1 in
		'fixup')
			command git commit --fixup=HEAD
			;;
		*)
			command git $@
			;;
	esac
}

symlink () {
	ln -s "$(realpath $1)" "$(realpath $2)"
}

ack () {
	grep -rs "$1" "${2:-.}"
}
