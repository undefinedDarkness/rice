
info:
	@echo "To install run 'make push'"

clean:
	rm -rf Scripts .config misc

REQUIRED_PROGRAMS=awesome git vim wezterm dmenu 
req:
	@for prog in $(REQUIRED_PROGRAMS); do  \
		if ! command -v $$prog &> /dev/null;\
	       	then \
			echo $$prog is not installed.;\
		fi ; \
	done

push: req
	@mkdir -p $(HOME)/.local/fonts
	@echo "Installing Configurations"
	cp -s `realpath .config/wezterm` $(HOME)/.config
	cp -s `realpath .config/awesome` $(HOME)/.config
	cp -s `realpath .config/nvim` $(HOME)/.config
	cp -s `realpath $(HOME)/.config/nvim` $(HOME)/.vim # Make Vim Read Config
	@echo "Installing Scripts"
	cp -s `realpath Scripts` $(HOME)/Documents
	@echo "Installing Fonts"
	cp -r misc/fonts/* $(HOME)/.local/fonts
	fc-cache -f -v
	@echo "Run 'vim +PlugInstall' to install required plugins."

pull: clean
	@echo "Pulling in configuration from system."
	@mkdir -p .config misc misc/fonts
	cp -ruf ~/.config/awesome .config
	@mkdir -p .config/nvim
	cp -ruf ~/.config/rofi .config
	cp -uf ~/.config/nvim/* .config/nvim || true
	cp -ruf ~/.config/wezterm .config
	@echo "Pulling in scripts"
	cp -ruf ~/Documents/Scripts .
	@echo "Pulling in fonts"
	cp -ruf ~/.local/share/fonts/* ./misc/fonts
	@echo -e "$$(tput bold)MANUAL: $$(tput sgr0) Put Stylus configs in misc/NAME.css"
	@echo -e "$$(tput bold)MANUAL:$$(tput sgr0) Copy patches for any suckless software as misc/SOFTWARE/MAIN.patch"

