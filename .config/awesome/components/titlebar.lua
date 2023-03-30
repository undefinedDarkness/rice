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
	)

	local colour = require('platform.stdlib').color

	awful.titlebar(c, {
		size = dpi(36),
		position = 'top',
	}):setup({
		{
			widget = wibox.container.margin,
			top = 8,
			left = 12,
			right = 8,
			bottom = 8,
		},
		{ widget = wibox.widget.separator, buttons = titlebar_buttons, color = '#00000000' },
		layout = wibox.layout.align.horizontal,
	})

	if awful.layout.get(mouse.screen) ~= awful.layout.suit.floating then
		awful.titlebar.hide(c)
	end
end)
