# Setup Live Reload
watch:
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
