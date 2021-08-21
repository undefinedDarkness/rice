#!/usr/bin/env bash

center () {
    columns="$(tput cols)"
    while IFS= read -r line; do
        printf "%*s\n" $(( (${#line} + columns) / 2)) "$line"
    done <<< "$1"
}

repeat () {
    for i in $(seq 1 $2)
    do
        echo -n $1
    done
}

os="$(. /etc/os-release && echo $NAME $VERSION_ID) @ $(uname -r | cut -d'-' -f1)"
pkgs="$(grep -G '^Package:' -c /var/lib/dpkg/status)"
pkgs=$(( pkgs - 32 )) # to be consistent with apt list
term="$TERM_PROGRAM @ $(basename $SHELL)"
line="+$(repeat '-' 28)+"

b=$'\e[1m'
re=$'\e[0m'

center "

$line

A B C D E F G H I J K L M
N O P Q R S T U V W X Y Z

1 2 3 4 5 6 7 8 9 0

a b c d e f g h i j k l m
n o p q r s t u v w x y z

() [] {} <> ? / \ : \" ' ;
! @ # $ % ^ & * _ = + - |
\` ~

--> !== ++ :=

$line

      ${b}os${re}: $os
  ${b}term${re}: $term"

line=+$(repeat '-' 28)+ # re assign or it wont work :/
printf "%*s\n\n" $(( 4 + columns / 2 )) "${b}pkg${re}: $pkgs" 

center "$line"
