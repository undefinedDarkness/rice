if { $argc != 1 } {
	puts "Invalid number of arguments, Need only 1."
	exit
}

set metadata ""
set failure 0
source "match-version.tcl"

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
	puts "\033\[31mFAIL\033\[0m $v"
}

proc report v {
	puts "\033\[34mINFO\033\[0m $v"
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
	
}

source "rice.tcl"

dict for {k v} $metadata {
	puts "\033\[1m[string totitle $k]\033\[0m: $v"
}
