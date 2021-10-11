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
					or C.gtk_lookup_icon(hints.app_icon:lower(), 48)

	if path then
		n.icon = path
	end
end)

naughty.connect_signal("request::display", function(n)
	n.timeout = 8

	local n_color = n.urgency == "critical" and beautiful.fg_red or beautiful.fg_red

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
								markup = C.colorify(beautiful.fg_inactive, n.title or n.app_name),
							},
							{
								widget = wibox.widget.textbox,
								markup = C.colorify(beautiful.fg_inactive, n.message),
							},
							layout = wibox.layout.flex.vertical,
						},
						layout = wibox.layout.align.horizontal,
					},
					widget = wibox.container.margin,
					margins = dpi(8),
				},
				widget = wibox.container.background,
				bg = beautiful.bg_overlay,
			},
			widget = wibox.container.margin,
			left = dpi(10),
		},
	})
end)
