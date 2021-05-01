#!/usr/bin/env bash

# Re-written in bash :sunglasses:
todo_file="$HOME/Documents/Scripts/todo.json"

case $1 in
  "output-awesome")
    jq -r '.[] | "\(.id):\(.title):\(.text)"' $todo_file 
    ;;
  "add-task-gui")
    user=$(zenity --forms --add-entry="Title" --add-entry="Text" --text="Add task:" --separator=";")
    IFS=';' read -ra DATA <<< "$user"

    title=${DATA[0]}
    text=${DATA[1]}

    t=$(jq ". + [{\"title\": \"$title\", \"text\": \"$text\", \"id\": $(date +%s)  }]" $todo_file)
    echo "$t" > $todo_file
    ;;
  "complete-task")
    t=$(jq ".[] | select(.id != $2)" $todo_file)
    echo "$t" > $todo_file
    ;;
esac
