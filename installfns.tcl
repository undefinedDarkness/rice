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

proc ask { prompt } {
	puts $prompt
	return [gets stdin]
}

}
