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
	--local time = os.date("%H:%M")

	local n_color = "#56949f"
	if n.urgency == "critical" then
		n_color = "#d7827e"
	end

	naughty.layout.box({
		notification = n,
		shape = function(cr, w, h)
			gears.shape.rounded_rect(cr, w, h, 3)
		end,
		type = "notification",
		-- minimum_width = 500,
		bg = n_color,
		border_width = dpi(0),
		-- border_color = beautiful.bg_lighter,
		widget_template = {
			{
				{
					{
						C.contain_image(n.icon, 64, 64, { resize = true }),
						{
							{
								widget = wibox.widget.textbox,
								markup = C.colorify("#575279", n.title or n.app_name),
								font = "UnifontMedium Nerd Font",
							},
							{
								widget = wibox.widget.textbox,
								markup = C.colorify("#575279", n.message),
								font = "UnifontMedium Nerd Font",
							},
							layout = wibox.layout.flex.vertical,
						},
						layout = wibox.layout.align.horizontal,
					},
					widget = wibox.container.margin,
					margins = dpi(8),
				},
				widget = wibox.container.background,
				bg = "#f2e9de",
			},
			widget = wibox.container.margin,
			left = dpi(10),
		},
	})
end)
