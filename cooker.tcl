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

proc fail v {
	report v "fail"
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
	set sys-version 0
	array set options { -version "" }
	array set options $args 
	
	if { [ auto_execok $bin ] eq "" } {
		fail "`$bin` not found."
		return 0
	}

	set version $options(-version) 
	if { $version ne "" && ![match-version $bin $version] } {
		return 0
	}

	report "$bin found installed"
}

proc :depends { dependencies } {
	foreach dependency [split $dependencies "\n"] {
		if { [string length $dependency] == 0 } {
			continue;
		}

		check-dependency {*}$dependency
	}
}

proc :install { steps } {
	namespace eval install_env $steps 
	report "Install completed!" "info"
}

source "rice.tcl"
