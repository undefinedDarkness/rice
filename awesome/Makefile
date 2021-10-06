# Setup Live Reload
watch-and-reload:
	@echo "Watching for file changes."
	@find . -name "*.lua" -not -path "./misc/libs/bling/*" -not -path "./archive/*" | entr -p awesome-client 'awesome.restart()'

# Format All Lua Files
format:
	find . -name "*.lua" -not -path "./misc/libs/bling/*" -not -path "./archive/*" -exec stylua {} \;

# Set Terminal
set-terminal:
	@sed -E -i 's/terminal = ".*?"/terminal = "$(TERMINAL)"/g' rc.lua

# Set launch script location
set-master-location:
	@sed -E -i 's!\[\[ .* launch \]\]!\[\[ $(LOCATION) launch \]\]!g' rc.lua

# TODO: watch-and-rebuild

# [FENNEL] Build
build:
	mkdir -p $(XDG_CONFIG_HOME)/awesome
	find -name "*.fnl" | while read -r line; do\
		case $$line in *macro*) continue ;; esac;\
		x="$${line%.fnl}";\
		x="$${x#./}";\
		echo '\033[1mBuilding:\033[0m '$$line '->' $(XDG_CONFIG_HOME)/awesome/$$x.lua;\
		mkdir -p $(XDG_CONFIG_HOME)/awesome/$$(dirname $$x);\
		fennel -c $$line > $(XDG_CONFIG_HOME)/awesome/$$x.lua;\
	done
