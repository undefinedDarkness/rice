local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal('request::activate', 'tasklist', { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)

local only_minimized = function(c, screen)
	return awful.widget.tasklist.filter.currenttags(c, screen) -- and c.minimized == true
end

return {
	widget = wibox.container.margin,
	margins = 6,
	awful.widget.tasklist({
		screen = mouse.screen,
		buttons = tasklist_buttons,
		filter = function(a, b)
			return true
		end,
		widget_template = {
			layout = wibox.layout.fixed.horizontal,
			{
				widget = wibox.widget.imagebox,
				id = 'icon_role',
			},
			{
				widget = wibox.widget.textbox,
				id = 'text_role',
			},
		},
		layout = {
			layout = wibox.layout.fixed.vertical,
			spacing = 16,
		},
	}),
}
