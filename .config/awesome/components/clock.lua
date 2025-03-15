local clock_hr = wibox.widget.textclock('%H')
clock_hr.font = 'Recursive Mono Casual Static Black 72'
local clock_min = wibox.widget.textclock('%M')
clock_min.font = 'Recursive Mono Casual Static Black 72'

local clock_date = wibox.widget.textclock('%d-%m-%Y')
clock_date.align = 'center'
clock_date.font = beautiful.font

local clock = wibox.widget({
	clock_hr,
	clock_min,
	clock_date,
	layout = wibox.layout.fixed.vertical,
})

local volume_widget = {
	widget = wibox.widget.progressbar,
	max_value = 100,
	color = '#f0f0f0',
	background_color = require('platform.stdlib').color.darken('#f0f0f0', 64),
	value = const,
	shape = require('platform.stdlib').rounded,
}

awesome.connect_signal('custom::volume_update', function(vol)
	volume_widget.value = vol
end)

local popup = awful.popup({
	position = 'left',
	screen = s,
	sticky = true,
	bg = beautiful.wibar_bg,
	visible = true,
	ontop = false,
	type = 'splash',
	width = 100,
	fg = beautiful.wibar_fg,
	placement = awful.placement.top_left,
	widget = {
		clock,
		top = 40,
		right = 40,
		left = 40,
		widget = wibox.container.margin,
	},
})

require('components.dashboard').register({
	widget = {
		{
			layout = wibox.layout.fixed.horizontal,
			spacing = 20,
			-- {
			-- 	{ volume_widget, widget = wibox.container.rotate, direction = 'east' },
			-- 	widget = wibox.container.constraint,
			-- 	height = 60,
			-- 	width = 20
			-- },
			clock,
		},
		widget = wibox.container.margin,
		right = 40,
		top = 40,
	},
	halign = 'right',
	valign = 'top',
})
