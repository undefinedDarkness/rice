if { $argc != 1 } {
	puts "Invalid number of arguments, Need only 1."
	exit
}

set metadata ""
set failure 0
source "match-version.tcl"
source "installfns.tcl"

proc :name name {
	upvar metadata metadata
	dict set metadata name "$name"	
}
proc :by author {
	upvar metadata metadata
	dict set metadata by "$author"
}
proc :repo url {
	upvar metadata metadata
	dict set metadata url "$url"
}

proc fail { { v "UNKNOWN" } } {
	report $v "fail"
	# puts "\033\[31mFAIL\033\[0m $v"
}

proc report { v { why "info" } } {
	if { $why eq "info" } {
		puts "\033\[34mINFO\033\[0m $v"
		} elseif { $why eq "warn" } {
		puts "\033\[33mWARN\033\[0m $v"
		} elseif { $why eq "install" } {
		puts "\033\[36mINSTALL\033\[0m $v"
		} else {
		puts "\033\[31mERROR\033\[0m $v"
	}
}

proc check-dependency {bin args} {
	# 1 - OK
	# 0 - FAIL
	set sys-version 0
	array set options { -version "" -optional "" -message "" }
	array set options $args 

	if { [ auto_execok $bin ] eq "" } {
		if { $options(-optional) ne "" } {
			report "optional dependency `$bin` not found. ($options(-message))" "warn"
			return 1
			} else {
			report "required dependency `$bin` not found. ($options(-message))" "error"
			return 0
		}
	}

	set version $options(-version) 
	if { $version ne "" && ![match-version $bin $version] } {
		return 0
	}

	report "$bin found installed ($options(-message))"
	return 1
}

proc :depends { dependencies } {
	foreach dependency [split $dependencies "\n"] {
		if { [string length $dependency] == 0 } {
			continue;
		}

		if { [check-dependency {*}$dependency] == 0 } {
			report "Exiting b/c of missing required dependency or version mismatch"
			exit 1
		}
	}
}

proc :install { steps } {
	# namespace eval install_env $steps 
	report "Install completed!" "info"
}

source "rice.tcl"
