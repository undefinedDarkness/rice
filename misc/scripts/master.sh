#!/usr/bin/env sh

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
		(setsid picom -c -C 2> /dev/null &) # Fork so the shell can die.
		exit
		;;
esac

# -- ALIASES & SETUP -- 

alias rm='rm -v' # verbose
alias cp='cp -v' # verbose
alias grep='grep --color=auto'
alias vim='nvim' 
alias wget='wget --hsts-file /dev/null' # Disable Wget History
alias gitFixup='git commit --fixup=HEAD' # Make a new fixup ~HEAD commit
alias gitShallowClone='git clone --depth 1' # Clone only last commit
alias mupdf='mupdf -C f0f0f0' # Set Background Tint
alias killall='pkill' # killall Doesn't exist sometimes

# Enable Auto Directory Change
case $SHELL in
	*bash) 
		shopt -s autocd # Allow Changing Directory Without Explicit cd
		shopt -s globstar # Make ** actually work.
		bind 'set enable-bracketed-paste on' # Enable Bracket Paste Mode
esac

export LESSHISTFILE=- # Disable Less History
export HISTFILE= # Disable History File
export PATH="$PATH:$HOME/.local/bin" # Path
export PS1="\[\e[36m\]\w\[\e[m\] \[\e[32m\]->\[\e[m\] " # Prompt
export EDITOR="nvim" # Set Editor

case "$(uname -r)" in
	*microsoft-standard-WSL2)

		# For WSL (Windows Subsystem For Linux)
		export DISPLAY="$(grep nameserver /etc/resolv.conf | sed 's/nameserver //'):0"
		export DISPLAY="$(sed -n 's/nameserver //p' /etc/resolv.conf):0"
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
	apt-cache --no-all-versions show "$1" | grep --color=none  '^Size: ' | numfmt --field=2 --to=si
}

# Compress File / Folder
compress () {
	tar_f=$(mktemp)
	# Tar if is directory
	if [ -d "$1" ]; then
		tar -cf "$tar_f" "$1"
	else
		tar_f=$1
	fi
	# Maximum compression
	zstd -22 --ultra -T0 -z "$tar_f" 
	rm "$tar_f"
}

# Get X11 Keynames & Numbers (From Arch Wiki)
keyNames () {
	xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

