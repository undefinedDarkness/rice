proc match-version {bin wanted} {
	set pattern {(\d+.\d+)(.\d+)?(\+)?}
	regexp $pattern $wanted version major-minor patch inc
	regexp $pattern [exec $bin --version] sys-version sys-major-minor
	
	if { $inc ne "" } {
		set version [string range $version 0 end-1]
	}

	if {${sys-major-minor} < ${major-minor}} {
		fail "Invalid version of $bin installed: ${sys-version}, want $wanted"
		return 0
	}
	return 1
}
