#!/usr/bin/env sh
# shellcheck disable=2059
basename() {
	if [ -z "${NO_TRIM_PATHS:-}" ]; then
		dir=${1%${1##*[!/]}}
		dir=${dir##*/}
		dir=${dir%"$2"}
		printf '%s\n' "${dir:-/}"
	else
		echo "$1"
	fi
}
calc() { awk "BEGIN{printf $*}"; }
f=$(mktemp)
printf "
\033[1mTimes are in milliseconds.\033[0m
Raw output file: \033[3m$f\033[0m

"

case $1 in
	"--no-exit")
		nvim --startuptime "$f" 
		;;
	*)
		nvim --startuptime "$f" +q
		;;
esac

final_t=$(tail -n1 "$f")
final_t=${final_t%% *}
printf "\033[1mTotal Time\033[0m: ${final_t}ms\n"

main () {
li=0
ll=
while read -r line; do
	# Ignore header.
	li=$(( li + 1 ))
	if [ $li -lt 7 ]; then
		continue
	fi

	cl_time=${line%% *}
	ll_time=${ll%% *}
	item=${line##*: }
	time=$(calc "$cl_time - ${ll_time:-0}")

	case $item in
		sourcing*)
			case "$item" in
				*\ /usr/share*)
					item="[\033[31mr\033[0m] ${item%% *} \033[34m$(basename "${item##* }")\033[0m"
					;;
				*)
					item="${item%% *} \033[34m$(basename "${item##* }")\033[0m"
					;;
			esac
		;;
	esac

	percent=$(calc "$time/$final_t * 100")
	printf "$time	%.2f%%	$item\n" "$percent"	

	ll=$line
done < "$f"

# rm "$f"
}
li=0
cols=$(stty size)
cols=${cols##* }
main | sort -r -n | while read -r line; do
	percent=$(echo "$line" | cut -d'	' -f2)
	percent=${percent%%%}
	printf "%s " "$line" 

	
	printf "%$(calc "($percent * (1/100)) * $cols + 2")s" '' | tr ' ' '='

	li=$(( li + 1 ))
	echo
done