#!/usr/bin/env bash

# Setup Colemak & Picom
case $1 in
	launch)
		printf "
\e[1mLAUNCH TASK:\e[0m
- Killing Picom\n"
		pkill -e picom
		printf "\n- Setting Colemak Keyboard Layout\n"
		xmodmap "$( dirname "$0" )"/xmodmap.colemak && xset r 66
		printf "\n- Launching Picom\n\n"
		picom -c -C -f -b\
			--shadow-radius=12\
			--shadow-opacity=0.3\
			--shadow-offset-y=-12\
			--shadow-offset-x=-12
		exit
		;;
esac

# -- ALIASES & SETUP -- 

alias rm='rm -v' 
alias mv='mv -v'
alias cp='cp -v'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias vim='nvim'
alias wget='wget --hsts-file /dev/null' # Disable Wget History
alias killall='pkill'
alias colemak="xmodmap ~/rice/scripts/xmodmap.colemak && xset r 66"
alias gitFixup='git commit --fixup=HEAD' # Make a new fixup ~HEAD commit
alias gitShallowClone='git clone --depth 1' # Clone only last commit
alias gitS='git status --short'

shopt -s autocd # Allow Changing Directory Without Explicit cd
shopt -s globstar # Make ** actually work.
bind 'set enable-bracketed-paste on' # Enable Bracket Paste Mode

export LESSHISTFILE=- # Disable Less History
export HISTFILE= # Disable History File
export PATH="$PATH:$HOME/.local/bin:$HOME/.deno/bin" # Path
export PS1="\[\e]0;SH: \W\a\]\[\e[36m\]\w\[\e[m\] \[\e[32m\]->\[\e[m\] " # Prompt
export EDITOR="nvim" # Set Editor

case "$(uname -r)" in
	*microsoft-standard-WSL2)

		# For WSL (Windows Subsystem For Linux)
		# shellcheck disable=2155
		export DISPLAY="$(grep nameserver /etc/resolv.conf | sed 's/nameserver //'):0"
		# shellcheck disable=2155
		export DISPLAY="$(sed -n 's/nameserver //p' /etc/resolv.conf):0"
		# shellcheck disable=2155
		export DISPLAY=$(ip route|awk '/^default/{print $3}'):0.0
		export LIBGL_ALWAYS_INDIRECT=1

		# Set Config Directory To Dotfiles
		export XDG_CONFIG_HOME=$HOME/rice/.config
		;;

esac

# -- FUNCTIONS --

# Memory Usage
memoryUsage () {
	ps_mem -p "$(pgrep "$1")"
}

# Symlink Files
symlink () {
	ln -s "$(realpath "$1")" "$(realpath "$2")"
}

# Search In Files
# shellcheck disable=2086
ack () {
	grep -rs --color=always $2 -- "$1"
}

# Use Nvim's Manpager as its simply better than less
man () {
	nvim +"Man $*" +"only"
}

# Get Package Size
packageSize() {
	if [ -n "$1" ]; then
		apt-cache --no-all-versions show "$1" | grep --color=none  '^Size: ' | numfmt --field=2 --to=si
	else
		dpkg --list |grep "^rc" | cut -d " " -f 3 | xargs sudo dpkg --purge 2> /dev/null
		dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n
	fi
}

# Get X11 Keynames & Numbers (From Arch Wiki)
keyNames () {
	xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

download () {
	curl -L -o "$(basename "$1")" "$1"
}
