-- Heavily inspired by javacafe's dotfiles (https://github.com/JavaCafe01/dotfiles/blob/master/.config/awesome/ui/notifs/init.lua)
local naughty = require("naughty")
local C = require("misc.libs.stdlib")

naughty.config.padding = dpi(8)
naughty.config.spacing = dpi(16)

naughty.config.defaults.timeout = 8
naughty.config.defaults.title = "Hello There!"
naughty.config.defaults.position = "bottom_right"
naughty.config.defaults.icon_size = dpi(48)

naughty.config.icon_formats = { "png", "svg" }

naughty.connect_signal("request::icon", function(n, context, hints)
	if context ~= "app_icon" then
		return
	end

	local path = require("menubar.utils").lookup_icon(hints.app_icon)
		or require("menubar.utils").lookup_icon(hints.app_icon:lower())

	if path then
		n.icon = path
	end
end)

naughty.connect_signal("request::display", function(n)
	n.timeout = 8
	local time = os.date("%H:%M")

	naughty.layout.box({
		notification = n,
		shape = function(cr, w, h)
			gears.shape.rounded_rect(cr, w, h, 5)
		end,
		type = "notification",
		minimum_width = 100,
		bg = "#282828",
		border_width = dpi(1),
		border_color = beautiful.bg_lighter,
		widget_template = {
			{
				{
					{
						widget = wibox.widget.imagebox,
						image = n.icon,
						resize = true,
						valign = "center",
						halign = "center",
						clip_shape = function(cr, w, h)
							gears.shape.rounded_rect(cr, w, h, 8)
						end,
					},
					widget = wibox.container.constraint,
					height = dpi(32),
					width = dpi(32),
				},
				{
					{
						{
							widget = wibox.widget.textbox,
							markup = n.title or n.app_name,
							align = "left",
							ellipsize = "none",
						},
						{
							widget = wibox.widget.textbox,
							text = n.message,
							ellipsize = "none",
						},
						layout = wibox.layout.fixed.vertical,
					},
					layout = wibox.container.margin,
					left = dpi(8),
				},
				layout = wibox.layout.fixed.horizontal,
			},
			widget = wibox.container.margin,
			left = dpi(15),
			right = dpi(15),
			top = dpi(8),
			bottom = dpi(8),
		},
	})
end)
