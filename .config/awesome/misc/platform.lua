local naughty = require("naughty")

-- Wallpaper
function set_wallpaper(s, wallpaper)
	if wallpaper then
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

screen.connect_signal("request::wallpaper", function(s)
	set_wallpaper(s, beautiful.wallpaper)
end)

-- Errors
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

-- Root Window Buttons
root.buttons(gears.table.join(
	awful.button({}, mouse.RIGHT, function()
		local clients = awful.screen.focused().selected_tag:clients()
		for _, v in ipairs(clients) do
			v.minimized = true
		end
		require("components.menu").qmenu:toggle()
	end),
	awful.button({}, mouse.SCROLL_UP, awful.tag.viewnext),
	awful.button({}, mouse.SCROLL_DOWN, awful.tag.viewprev)
))

-- Client Buttons
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

-- Rules
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

-- Signals
local lookup_icon = require("menubar.utils").lookup_icon
client.connect_signal("manage", function(c)
	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		awful.placement.no_offscreen(c)
	end

	if c.class == "St" or c.class == "st-256color" then
		local new_icon = gears.surface(lookup_icon("terminal"))
		c.icon = new_icon._native
	end
end)

-- require("misc.firefox").attach()
