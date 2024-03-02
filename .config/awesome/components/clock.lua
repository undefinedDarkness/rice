local clock_hr = awful.widget.textclock('%H')
clock_hr.font = 'Recursive Mono Casual Static Black 72'
local clock_min = awful.widget.textclock('%M')
clock_min.font = 'Recursive Mono Casual Static Black 72'
local clock = wibox.widget({
	clock_hr,
	clock_min,
	layout = wibox.layout.fixed.vertical,
})

awful.popup({
	position = 'left',
	screen = s,
	sticky = true,
	bg = beautiful.wibar_bg,
	visible = true,
	ontop = false,
	type = 'splash',
	width = 100,
	fg = beautiful.wibar_fg,
	placement = function(d)
		awful.placement.top_left(d, { margins = { left = 20, top = 20 } })
	end,
	widget = {
		{
			clock,
			layout = wibox.layout.fixed.vertical,
			spacing = 8,
		},
		widget = wibox.container.margin,
	},
})
