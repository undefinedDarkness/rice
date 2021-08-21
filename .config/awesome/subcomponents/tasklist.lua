local force_center = require("misc.libs.stdlib").force_center

return function(s)
	return force_center(wibox.widget{awful.widget.tasklist {
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		layout = {
			spacing = dpi(10),
			layout = wibox.layout.fixed.vertical
		},
		style = {
			bg_normal = '#00000000'
		},
		widget_template = {
			{
				{
					widget = wibox.widget.imagebox,
					id = 'icon_role'
				},
				width = dpi(24),
				height = dpi(24),
				widget = wibox.container.constraint,
			},
			widget = wibox.container.background, -- THIS IS ESSENTIAL!
			update_callback = require('bling.widget.tabbed_misc').custom_tasklist,
			id = 'background_role',
		}
	},
	widget = wibox.container.margin,
	top = dpi(8),
	bottom = dpi(4)
})
end
