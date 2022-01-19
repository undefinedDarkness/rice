local clock = wibox.widget.textclock('%H:%M')
clock.font = 'Roboto Medium 64'

awful.popup({
	placement = awful.placement.centered,
	input_passthrough = true,
	widget = clock,
	bg = '#00000000',
	fg = require('misc.libs.stdlib').color.darken(beautiful.wallpaper_bg, 70),
	type = 'dock',
})
