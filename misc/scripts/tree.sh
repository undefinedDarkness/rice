#!/bin/sh

max_depth=${max_depth:-30}
spacer='     '

# Taken from pure-sh-bible
basename() {
    dir=${1%${1##*[!/]}}
    dir=${dir##*/}
    dir=${dir%"$2"}
    printf '%s\n' "${dir:-/}"
}

fileformat () {
	case $1 in
	'ai')
		echo ''
		;;
	'awk')
		echo ''
		;;
	'bash')
		echo ''
		;;
	'bat')
		echo ''
		;;
	'bmp')
		echo ''
		;;
	'c')
		echo ''
		;;
	'c++')
		echo ''
		;;
	'cc')
		echo ''
		;;
	'clj')
		echo ''
		;;
	'cljc')
		echo ''
		;;
	'cljs')
		echo ''
		;;
	'coffee')
		echo ''
		;;
	'conf')
		echo ''
		;;
	'cp')
		echo ''
		;;
	'cpp')
		echo ''
		;;
	'cs')
		echo ''
		;;
	'csh')
		echo ''
		;;
	'css')
		echo ''
		;;
	'cr')
		echo ''
		;;
	'cxx')
		echo ''
		;;
	'd')
		echo ''
		;;
	'dart')
		echo ''
		;;
	'db')
		echo ''
		;;
	'diff')
		echo ''
		;;
	'dump')
		echo ''
		;;
	'edn')
		echo ''
		;;
	'eex')
		echo ''
		;;
	'ejs')
		echo ''
		;;
	'elm')
		echo ''
		;;
	'erl')
		echo ''
		;;
	'ex')
		echo ''
		;;
	'exs')
		echo ''
		;;
	'f#')
		echo ''
		;;
	'fish')
		echo ''
		;;
	'fs')
		echo ''
		;;
	'fsi')
		echo ''
		;;
	'fsscript')
		echo ''
		;;
	'fsx')
		echo ''
		;;
	'gemspec')
		echo ''
		;;
	'gif')
		echo ''
		;;
	'go')
		echo ''
		;;
	'h')
		echo ''
		;;
	'haml')
		echo ''
		;;
	'hbs')
		echo ''
		;;
	'hh')
		echo ''
		;;
	'hpp')
		echo ''
		;;
	'hrl')
		echo ''
		;;
	'hs')
		echo ''
		;;
	'htm')
		echo ''
		;;
	'html')
		echo ''
		;;
	'hxx')
		echo ''
		;;
	'ico')
		echo ''
		;;
	'ini')
		echo ''
		;;
	'java')
		echo ''
		;;
	'jl')
		echo ''
		;;
	'jpeg')
		echo ''
		;;
	'jpg')
		echo ''
		;;
	'js')
		echo ''
		;;
	'json')
		echo ''
		;;
	'jsx')
		echo ''
		;;
	'ksh')
		echo ''
		;;
	'leex')
		echo ''
		;;
	'less')
		echo ''
		;;
	'lhs')
		echo ''
		;;
	'lua')
		echo ''
		;;
	'markdown')
		echo ''
		;;
	'md')
		echo ''
		;;
	'mdx')
		echo ''
		;;
	'mjs')
		echo ''
		;;
	'ml')
		echo 'λ'
		;;
	'mli')
		echo 'λ'
		;;
	'mustache')
		echo ''
		;;
	'php')
		echo ''
		;;
	'pl')
		echo ''
		;;
	'pm')
		echo ''
		;;
	'png')
		echo ''
		;;
	'pp')
		echo ''
		;;
	'ps1')
		echo ''
		;;
	'psb')
		echo ''
		;;
	'psd')
		echo ''
		;;
	'py')
		echo ''
		;;
	'pyc')
		echo ''
		;;
	'pyd')
		echo ''
		;;
	'pyo')
		echo ''
		;;
	'r')
		echo 'ﳒ'
		;;
	'rake')
		echo ''
		;;
	'rb')
		echo ''
		;;
	'rlib')
		echo ''
		;;
	'rmd')
		echo ''
		;;
	'rproj')
		echo '鉶'
		;;
	'rs')
		echo ''
		;;
	'rss')
		echo ''
		;;
	'sass')
		echo ''
		;;
	'scala')
		echo ''
		;;
	'scss')
		echo ''
		;;
	'sh')
		echo ''
		;;
	'slim')
		echo ''
		;;
	'sln')
		echo ''
		;;
	'sql')
		echo ''
		;;
	'styl')
		echo ''
		;;
	'suo')
		echo ''
		;;
	'swift')
		echo ''
		;;
	't')
		echo ''
		;;
	'tex')
		echo 'ﭨ'
		;;
	'toml')
		echo ''
		;;
	'ts')
		echo ''
		;;
	'tsx')
		echo ''
		;;
	'twig')
		echo ''
		;;
	'vim')
		echo ''
		;;
	'vue')
		echo '﵂'
		;;
	'webmanifest')
		echo ''
		;;
	'webp')
		echo ''
		;;
	'xcplayground')
		echo ''
		;;
	'xul')
		echo ''
		;;
	'yaml')
		echo ''
		;;
	'yml')
		echo ''
		;;
	'zsh')
		echo ''
		;;
	esac
}

output () {

	left="$(printf "%$(($2))s" | tr " " "\t")"
	
	if [ "$2" -gt "$max_depth" ]; then
		echo "$left-> max depth exceeded"
		return
	fi

	files=''
	last_file='' # not sure how to correctly do this
	folders=''
	for item in "$1"/*; do
		if [ -f "$item" ]; then
			# is file
			files="$files|$item" 
			last_file="$item"
		else
			# is directory
			folders="$folders|$item"
		fi
	done


	printf "%s\e[34m \e[0m %s/\n" "$left" "$(basename "$1")"
	IFS="|"
	left="$left$spacer"
	for file in $files; do

		if [ -z "$file" ]; then
			continue
		fi

		icon=$(fileformat "${file##*.}")
		if [ -n "$icon" ]; then
			icon="$icon  "
		fi

		if [ "$last_file" = "$file" ]; then
			echo "$left└ $icon$(basename "$file")"
		else
			echo "$left├ $icon$(basename "$file")"
		fi
	done

	for folder in $folders; do
		if [ -z "$folder" ]; then
			continue
		fi
		output "$folder" $(($2 + 1))
	done
}

start_dir=${1:-.}

if ! [ -d "$start_dir" ]; then
	echo "$start_dir isnt a valid directory!"
	return
fi

# hack because realpath / readlink might not exist / work, pwd should work
original_dir=$(pwd)
cd "$start_dir" || exit
start_dir=$(pwd -P)
cd "$original_dir" || exit

output "$start_dir" 0
