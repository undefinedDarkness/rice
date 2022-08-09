local math = require('math')

client.connect_signal('request::titlebars', function(c)
	-- Titlebar Buttons
	local raise = function()
		c:emit_signal('request::activate', 'titlebar', { raise = true })
	end

	local titlebar_buttons = gears.table.join(
		awful.button({}, mouse.LEFT, function()
			raise()
			awful.mouse.client.move(c)
		end),
		awful.button({}, mouse.RIGHT, function()
			raise()
			awful.mouse.client.resize(c)
		end),
		awful.button({ 'Shift' }, mouse.LEFT, function()
			raise()
			c.maximized = not c.maximized
		end)
		-- awful.button({ 'Shift' }, mouse.RIGHT, function()
		-- 	raise()
		-- 	require('subcomponents.layout')(c)
		-- end)
	)

	local colour = require('platform.stdlib').color
	local close = wibox.widget({
		widget = wibox.container.background,
		draw_empty = true,
		bg = colour.darken(beautiful.titlebar_bg_focus, 30),
		forced_width = 20,
		shape = function(cr, w, h)
			gears.shape.transform(gears.shape.cross):rotate_at(w / 2, h / 2, math.pi / 4)(cr, w, h, 4)
		end,
		buttons = awful.button({}, mouse.LEFT, function()
			c:kill()
		end),
	})

	local minimize = wibox.widget({
		widget = wibox.container.background,
		draw_empty = true,
		bg = '#212121',
		forced_width = 25,
		shape = function(cr, w, h)
			gears.shape.transform(gears.shape.isosceles_triangle)
				:rotate_at(w / 2, h / 2, math.pi)
				:scale(0.45, 0.45)
				:translate(20, 10)(cr, w, h)
		end,
		buttons = awful.button({}, mouse.RIGHT, function()
			c.minimized = true
		end),
	})

	awful.titlebar(c, {
		size = dpi(36),
		position = 'top',
	}):setup({
		{
			{
				close,
				minimize,
				layout = wibox.layout.fixed.horizontal,
				spacing = 8,
			},
			widget = wibox.container.margin,
			top = 8,
			left = 12,
			right = 8,
			bottom = 8,
		},
		{ widget = wibox.widget.separator, buttons = titlebar_buttons, color = '#00000000' },
		-- buttons = titlebar_buttons,
		layout = wibox.layout.align.horizontal,
	})
end)
