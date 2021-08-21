CC_PRE=`pkg-config --cflags gtk+-3.0`
CC_POST=`pkg-config --libs gtk+-3.0`
CC_ETC=-Wall -Wextra -pedantic -Os -g

all: get-icon todo

clangd:
	echo $(CC_PRE)$(CC_POST) | tr ' ' '\n' > compile_flags.txt

todo:
	gcc todo.c -o ./bin/todo $(CC_ETC)

get-icon:
	gcc $(CC_PRE) get-icon.c -o ./bin/get-icon $(CC_POST) $(CC_ETC)
