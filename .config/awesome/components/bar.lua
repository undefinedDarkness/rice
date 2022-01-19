local c = require('misc.libs.stdlib').color

local cl = wibox({
	widget = {
		widget = awful.widget.layoutbox,
		buttons = awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
	},
	width = dpi(40),
	height = dpi(40),
	bg = '#00000000',
	type = 'dock',
	visible = true,
	screen = s,
})

awful.placement.bottom_right(cl, { margins = { bottom = dpi(16), right = dpi(16) } })
