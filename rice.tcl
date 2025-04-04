:name rice
:by undefinedDarkness
:repo https://github.com/undefinedDarkness/rice

:depends {
	awesome -message "Window Manager" -optional true
	nvim -version 0.7+ -message "Editor" -optional true
	picom -message "Compositer"
	wezterm -message "Configured Terminal" -optional true
	playerctl -message "Used to get now playing"
	wget -message "Used to download files" 
	nm-applet -message "The tray applet for networks"
	dmenu -optional true -message "Used for launching applications" 
	rofi -optional true -message "Can be used instead of rofi"
	maim -optional true -message "Used for screenshots"
}

:install {
	# Basic Symlink
	file symlink [file normalize $RICE/.config/awesome] $CONFIG/awesome
	file symlink [file normalize $RICE/.config/nvim] $CONFIG/nvim

	# Install Font
	cd ~/.local/share
	file mkdir fonts/FantasqueSansMono
	cd FantasqueSansMono
	cmd wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FantasqueSansMono.zip
	cmd unzip FantasqueSansMono.zip
	file delete FantasqueSansMono.zip
}
