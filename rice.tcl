:name rice
:by undefinedDarkness
:repo https://github.com/undefinedDarkness/rice

:depends {
	awesome 
	nvim -version 0.7+
	picom
	xterm
	playerctl
	wget
}

:install {
	symlink $RICE/.config/awesome $CONFIG/awesome
	symlink $RICE/.config/nvim $CONFIG/nvim
	set user_terminal [ask "What Terminal Do You Use (command name)?"]
	cmd wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FantasqueSansMono.zip
}
