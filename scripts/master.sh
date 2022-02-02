#!/usr/bin/env bash

# -- ALIASES & SETUP -- 

alias rm='rm -v' 
alias mv='mv -v'
alias cp='cp -v'
# This was a really bad idea ;-; alias cat='cat -n'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias vim='nvim'
#alias emacs='TERM=xterm-24bit emacs '
alias wget='wget --hsts-file /dev/null' # Disable Wget History
alias killall='pkill'
alias colemak="xmodmap ~/rice/scripts/xmodmap.colemak && xset r 66"
alias gitFixup='git commit --fixup=HEAD' # Make a new fixup ~HEAD commit
alias gitShallowClone='git clone --depth 1' # Clone only last commit
alias gitS='git status --short'

shopt -s autocd # Allow Changing Directory Without Explicit cd
shopt -s globstar # Make ** actually work.
bind 'set enable-bracketed-paste on' # Enable Bracket Paste Mode

export DOTNET_CLI_TELEMETRY_OPTOUT=1
# export GTK_THEME="phocus"
export LESSHISTFILE=- # Disable Less History
export HISTFILE= # Disable History File
export PATH="$PATH:$HOME/.local/bin:$HOME/.deno/bin" # Path
export PS1="\[\e]0;SH: \W\a\]\[\e[36m\]\w\[\e[m\] \[\e[32m\]->\[\e[m\] " # Prompt

case "$(uname -r)" in
	*microsoft-standard-WSL2)

		# For WSL (Windows Subsystem For Linux)
		# shellcheck disable=2155
		export DISPLAY="$(grep nameserver /etc/resolv.conf | sed 's/nameserver //'):0"
		# shellcheck disable=2155
		export DISPLAY="$(sed -n 's/nameserver //p' /etc/resolv.conf):0"
		# shellcheck disable=2155
		export DISPLAY=$(ip route | awk '/^default/{print $3}'):0.0
		#export LIBGL_ALWAYS_INDIRECT=1

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
if command -v "nvim" &> /dev/null; then
    man () {
	nvim +"Man $*" +"only"
    }
    export EDITOR="nvim" # Set Editor
fi

# Get Package Size
packageSize() {
	if [ -n "$1" ]; then
	    apt-cache --no-all-versions show "$1" \
		| grep --color=none  '^Size: ' \
		| numfmt --field=2 --to=si
	else
		dpkg --list | grep "^rc" | cut -d " " -f 3 | xargs sudo dpkg --purge 2> /dev/null
		dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n
	fi
}

# Get X11 Keynames & Numbers (From Arch Wiki)
keyNames () {
	xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

download () {
	curl --progress-bar -L -o "$(basename "$1")" "$1"
}
