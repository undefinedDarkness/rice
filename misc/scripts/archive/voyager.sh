#!/usr/bin/env bash

url="https://theskylive.com/voyager1-info"
path="/tmp/voyager-info.txt"

# Update if not already existing
# TODO: Update if info is old
if ! [ -f $path ]; then
	curl $url > $path
fi

# And so and so forth
case $1 in
	distance_km)
		echo "$(grep -Po 'The distance of .* from Earth is currently \K([0-9,]+)' $path)"
		;;
	distance_au)
		echo "$(grep -Po 'equivalent to \K([0-9,.]+)(?=.*Astronomical Units.*)' $path)"
		;;
	constellation)
		echo "$(grep -Po 'in <a href="/sky/constellations.*>\K(\w+)(?=<)' -m1 $path)"
		;;
esac
