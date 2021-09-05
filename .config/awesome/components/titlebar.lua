local trim_long_name = require("misc.libs.stdlib").trim_long

client.connect_signal("request::titlebars", function(c)
	local last_left_click
	local titlebar_buttons = gears.table.join(
		awful.button({}, mouse.LEFT, function()

			c:emit_signal("request::activate", "titlebar", { raise = true })
			if os.time() - (last_left_click or 0) < 1 then
				-- assume to be double click
				c.maximized = not c.maximized
			else
				awful.mouse.client.move(c)
			end
			last_left_click = os.time()
		end),
		awful.button({}, mouse.RIGHT, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	local close_button = awful.titlebar.widget.closebutton(c)
	close_button.forced_height = dpi(24)
	close_button.forced_width = dpi(24)
	close_button.halign = "right"
	close_button.valign = "center"

	local center = wibox.widget({
		{
			widget = wibox.widget.textbox,
		},
		layout = wibox.layout.flex.horizontal,
		buttons = titlebar_buttons,
	})
	center:connect_signal("mouse::enter", function()
		mouse.screen.activetext.text = c.name
	end)
	center:connect_signal("mouse::leave", function()
		mouse.screen.activetext.text = ""
	end)

	awful.titlebar(c, {
		size = dpi(44),
		bg_focus = "#e0e0e0",
		bg_normal = "#373b41",
		position = "top",
	}):setup({
		{
			{
				require("misc.libs.bling.widget.tabbed_misc").titlebar_indicator(c, {
					widget_template = {
						{
							widget = wibox.widget.imagebox,
							align = "center",
							valign = "center",
						},
						widget = wibox.container.constraint,
						width = 20,
						height = 20,
						id = "bg_role",
						update_callback = function(widget, client, group)
							local im = widget.children[1]
							if client == group.clients[group.focused_idx] then
								im.image = _config_dir .. "/theme/assets/add_black_24dp.svg"
							else
								im.image = _config_dir .. "/theme/assets/remove_black_24dp.svg"
							end
						end,
					},
				}),
				widget = wibox.container.margin,
				left = dpi(10),
			},
			center,
			{
				close_button,
				layout = wibox.layout.fixed.horizontal,
			},
			layout = wibox.layout.align.horizontal,
		},
		widget = wibox.container.margin,
		right = dpi(8),
	})
end)
