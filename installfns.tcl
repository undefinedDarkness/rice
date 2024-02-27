namespace eval install_env {

variable HOME $::env(HOME)

if { [info exists ::env(XDG_CONFIG_HOME)] } {
	variable CONFIG $::env(XDG_CONFIG_HOME)
} else {
	variable CONFIG "$HOME/.config"
}

variable RICE [file dirname [file normalize [info script]]]

proc cmd { args } {
	chan configure stdout -buffering none
	report "Running `$args`" "install"
	exec >&/dev/null {*}$args
}

proc symlink { from to } {
	set real_from [ file normalize $from ]
	# set real_to [ file normalize $to ]

	report "Linking $to to $real_from" "install"
	# file link -symlink $real_to $real_from
}

proc ask { prompt } {
	puts $prompt
	return [gets stdin]
}

}
