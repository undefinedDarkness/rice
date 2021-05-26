
.DEFAULT_GOAL := push

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
	ln -s `realpath .config/wezterm` $(HOME)/.config/wezterm
	ln -s `realpath .config/awesome` $(HOME)/.config/awesome
	ln -s `realpath .config/vim` $(HOME)/.config/vim
	ln -s `realpath $(HOME)/.config/vim` $(HOME)/.vim # Make Vim Read Config
	@echo "Installing Scripts"
	ln -s `realpath Scripts` $(HOME)/Documents/Scripts
	@echo "Installing Fonts"
	cp -r misc/fonts/* $(HOME)/.local/fonts
	fc-cache -f -v
	@echo "Run 'vim +PlugInstall' to install required plugins."

pull: clean
	@echo "Pulling in configuration from system."
	@mkdir -p .config misc misc/fonts
	cp -r ~/.config/awesome .config
	cp  -r ~/.config/vim .config
	cp -r ~/.config/wezterm .config
	@echo "Pulling in scripts"
	cp -r ~/Documents/Scripts .
	@echo "Pulling in fonts"
	cp -r ~/.local/share/fonts/* ./misc/fonts
	@echo "MANUAL: Put Stylus configs in misc/discord.css"

