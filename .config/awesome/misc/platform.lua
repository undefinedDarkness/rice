-- General Setup of awesomewm
-- Tags
-- Layouts
-- Error handling
-- Root / Client buttons
-- Rules

-- Set Wallpaper
screen.connect_signal("request::wallpaper", function(s)
	bling.module.tiled_wallpaper("♟︎", s, {
		fg = beautiful.wallpaper_fg,
		bg = beautiful.wallpaper_bg,
		offset_y = 25,
		offset_x = 45,
		font = "UnifontMedium Nerd Font",
		font_size = 23,
		padding = 100,
		zickzack = true,
	})
end)

-- Setup Window Layouts
tag.connect_signal("request::default_layouts", function()
	awful.layout.append_default_layouts({
		awful.layout.suit.floating,
		awful.layout.suit.tile,
		awful.layout.suit.spiral.dwindle,
	})
end)

-- Setup Tags
screen.connect_signal("request::desktop_decoration", function(s)
	awful.tag(beautiful.workspaces, s, awful.layout.layouts[1])
end)

-- Errors {{{
local naughty = require("naughty")
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

local in_error = false
awesome.connect_signal("debug::error", function(err)
	-- Make sure we don't go into an endless error loop
	if in_error then
		return
	end
	in_error = true

	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, an error happened!",
		text = tostring(err),
	})
	in_error = false
end)

-- }}}

-- Root Window Buttons {{{
root.buttons(gears.table.join(
	awful.button({}, mouse.RIGHT, function()
		require("subcomponents.menu")()
	end),
	awful.button({}, mouse.SCROLL_UP, awful.tag.viewnext),
	awful.button({}, mouse.SCROLL_DOWN, awful.tag.viewprev)
))

-- }}}

-- Client Buttons {{{
clientbuttons = gears.table.join(
	awful.button({}, mouse.LEFT, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, mouse.LEFT, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, mouse.RIGHT, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)
-- }}}

-- Rules {{{
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = require("misc.keybindings.client"),
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},

	-- Add titlebars to normal clients and dialogs
	{
		rule_any = {
			type = { "normal", "dialog" },
		},
		properties = { titlebars_enabled = true },
	},

	-- 🤮 Disable Titlebars For CSD Apps
	{
		rule_any = {
			class = {
				"Mixer",
				"Gnome-font-viewer",
				"File-roller",
				"Nautilus",
				"Myxer",
				"Eog",
				"Evince",
				"Gedit",
				"Gnome-calculator",
			},
		},
		properties = { titlebars_enabled = false },
	},
}

-- }}}

-- Signals {{{
local lookup_icon = require("menubar.utils").lookup_icon
client.connect_signal("manage", function(c)
	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		awful.placement.no_overlap(c) --offscreen(c)
	end
end)

-- }}}
