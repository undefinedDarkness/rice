build:
	find -name "*.fnl" | while read -r line; do;\
			case $$line in *macro*) continue ;; esac;\
			rootdir="$$XDG_CONFIG_HOME/nvim";\
			if [[ "$$line" != "./init.fnl" ]]; then rootdir="$$rootdir/lua"; fi;\
			file="$${line%.fnl}";\
			file="$${file#./}";\
			printf '\033[1mBuilding:\033[0m '$$line '->' $$rootdir/$$file.lua;\
			mkdir -p "$$rootdir/$$(dirname $$file)";\
			fennel -c "$$line" > "$$rootdir/$$file.lua";\
	done

watch:
		@echo "Watching for changes"
		@find -name "*.fnl" | entr make build
