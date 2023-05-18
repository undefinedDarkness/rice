-- Heavily inspired by javacafe's dotfiles (https://github.com/JavaCafe01/dotfiles/blob/master/.config/awesome/ui/notifs/init.lua)
local naughty = require('naughty')
local C = require('platform.stdlib')

naughty.config.padding = dpi(8)
naughty.config.spacing = dpi(16)

naughty.config.defaults.timeout = 8
naughty.config.defaults.title = 'Hello There!'
naughty.config.defaults.position = 'top_left'


naughty.connect_signal('request::display', function(n)
	n.timeout = 8
	n.position = 'bottom_right'

	local icon = n.icon or n.image or n.app_icon
	-- if icon == nil and n.app_name ~= nil then
		-- icon = C.gtk_lookup_name(n.app_name)
	-- end


	naughty.layout.box({
		notification = n,
		shape = function(cr, w, h)
			gears.shape.rounded_rect(cr, w, h, 5)
		end,
		type = 'notification',
		minimum_width = 100,
		fg = '#f7f7f7',
		bg = '#111111',
		widget_template = {
			{
				widget = wibox.container.background,
				forced_width = 8,
				bg = n.urgency == 'low' and 'blue' or (n.urgency == 'critical' and 'red' or 'orange'),
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
					{
						widget = wibox.widget.textbox,
						text = n.title,
						valign = 'bottom',
					},
					{
						valign = 'top',
						widget = wibox.widget.textbox,
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
