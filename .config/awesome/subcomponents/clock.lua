local clock = wibox.widget.textclock('%H:%M')
clock.font = 'Fraunces 64'

awful.popup({
	placement = awful.placement.centered,
	input_passthrough = true,
	widget = clock,
	bg = '#f0f0f0',
	fg = '#181818',
	type = 'dock',
})
