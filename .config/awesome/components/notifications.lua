-- Heavily inspired by javacafe's dotfiles (https://github.com/JavaCafe01/dotfiles/blob/master/.config/awesome/ui/notifs/init.lua)
local naughty = require('naughty')
local C = require('platform.stdlib')

naughty.config.padding = dpi(8)
naughty.config.spacing = dpi(16)

naughty.config.defaults.timeout = 8
naughty.config.defaults.title = '┗ ┻ ┣'

naughty.connect_signal('request::display', function(n)
	n.timeout = 8
	n.position = 'top_right'

	local icon = n.icon or n.image or n.app_icon

	naughty.layout.box({
		notification = n,
		shape = function(cr, w, h)
			gears.shape.rounded_rect(cr, w, h, 5)
		end,
		type = 'notification',
		minimum_width = 100,
		fg = beautiful.palette.black,
		border = 0,
		bg = '#f0f0f0',--C.color.hexa(beautiful.dark, 0.85),
		widget_template = {
			{
				widget = wibox.container.background,
				forced_width = 8,
				bg = n.urgency == 'low' and beautiful.palette.blue or (n.urgency == 'critical' and beautiful.palette.red or beautiful.palette.gold),
			},
			{
				{
					{
						halign = 'center',
						valign = 'center',
						widget = wibox.widget.imagebox,
						image = icon,
						resize = true,
					},
					widget = wibox.container.constraint,
					width = 150,
					height = 100,
				},
				widget = wibox.container.margin,
				margins = 8,
			},
			{
				{
					layout = wibox.layout.flex.vertical,
					spacing = 8,
					{
						widget = wibox.widget.textbox,
						text = n.title,
						font = 'azukifontP 14',
						valign = 'bottom',
					},
					{
						valign = 'top',
						widget = wibox.widget.textbox,
						font = 'azukifontP 14',
						markup = n.message,
					},
				},
				widget = wibox.container.margin,
				margins = 8,
			},

			layout = wibox.layout.fixed.horizontal,
		},
	})
end)
