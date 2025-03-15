local wezterm = require 'wezterm'
local config = {}

-- Colorscheme
-- Monokai Pro Spectrum
config.colors = {
	foreground = "#F7F1FF",
	background = "#222222",
	cursor_bg = "#F7F1FF",
	cursor_border = "#F7F1FF",
	cursor_fg = "#222222",
	selection_bg = "#F7F1FF",
	selection_fg = "#222222",
	scrollbar_thumb = "#444444",

	ansi = {
		"#131313", -- black
		"#FC618D", -- red
		"#7BD88F", -- green
		"#FCE566", -- yellow
		"#948AE3", -- blue
		"#FD9353", -- purple
		"#5AD4E6", -- cyan
		"#FFFFFF", -- white
	},
	brights = {
		"#191919", -- bright black
		"#FC618D", -- bright red
		"#7BD88F", -- bright green
		"#FCE566", -- bright yellow
		"#948AE3", -- bright blue
		"#FD9353", -- bright purple
		"#5AD4E6", -- bright cyan
		"#FFFFFF", -- bright white
	},
}

-- Window Frame (2px) & Padding (20px)
config.window_frame = {
	border_left_width = '2px',
	border_right_width = '2px',
	border_bottom_height = '2px',
	border_top_height = '2px',
	border_left_color = '#333333',
	border_right_color = '#333333',
	border_bottom_color = '#333333',
	border_top_color = '#333333',
	font = wezterm.font("Ubuntu Sans")
}
config.window_padding = {
	left = 20,
	right = 20,
	top = 20,
	bottom = 20,
}

-- Misc Config
config.enable_scroll_bar = true
-- config.hide_tab_bar_if_only_one_tab = true
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
-- config.integrated_title_button_style = "Gnome"
-- config.use_fancy_tab_bar = false

-- Font
-- config.font = wezterm.font("Liga SFMono Nerd Font")
config.font = wezterm.font("IosevkaTerm Nerd Font")
-- config.font = wezterm.font("Cozette")
config.font_size = 12

-- config.front_end = "WebGpu"

-- Key Bindings
config.keys = {
    -- Split pane vertically (new pane on the right)
    {
      key = "h",
      mods = "CTRL|SHIFT",
      action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
    },

    -- Split pane horizontally (new pane below)
    {
      key = "b",
      mods = "CTRL|SHIFT",
      action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
    },
	{
      key = "t",
      mods = "CTRL",
      action = wezterm.action.SpawnTab "CurrentPaneDomain",
    },
  }

return config
