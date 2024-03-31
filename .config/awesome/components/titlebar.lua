local math = require('math')
local std = require('platform.stdlib')

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


    local close_button = awful.titlebar.widget.closebutton(c)
	close_button.forced_height = dpi(24)
	close_button.forced_width = dpi(24)

	-- local max_btn = awful.titlebar.widget.maximizedbutton(c)
	-- max_btn.forced_width = 24
	-- max_btn.forced_height = 24

	awful
		.titlebar(c, {
			size = dpi(36),
			position = beautiful.titlebar_position,
		})
		:setup({
			{
				{
				    close_button,
					layout = wibox.layout.fixed.horizontal,
				},
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
		awful.titlebar.hide(c, beautiful.titlebar_position)
	end
end)
