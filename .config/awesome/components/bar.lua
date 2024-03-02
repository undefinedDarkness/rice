local cl = require('platform.stdlib') --.color
-- vim:fdm=marker:
-- awful.screen.connect_for_each_screen(function(s) end)
--

local w = wibox.widget.systray()

awful.popup {
	visible = true,
	ontop = false,
	widget = {
		{ w, widget = wibox.container.constraint, width = 200, height = 24},
		layout = wibox.layout.fixed.horizontal
	},
	type = 'splash',
	placement = function(d)
		awful.placement.bottom_left(d, { margins = 20 })
	end
}
