client.connect_signal("request::titlebars", function(c)
	-- Titlebar Buttons
	local raise = function()
		c:emit_signal("request::activate", "titlebar", { raise = true })
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
	awful.button({ "Shift" }, mouse.LEFT, function()
		raise()
		c.maximized = not c.maximized
	end),
	awful.button({ "Shift" }, mouse.RIGHT, function()
		raise()
		require("subcomponents.layout")(c)
	end)
	)

	local title = wibox.widget.textbox(c.name:lower())
	c:connect_signal("property::name", function()
		if c.class == "Thunar" then
			title.text = "fm: " .. c.name
		else
			title.text = c.name:lower()
		end
	end)

	-- Titlebar Setup!
	awful.titlebar(c, {
		size = dpi(30),
		bg_focus = beautiful.fg_subtle,
		bg_normal = beautiful.fg_magenta,
		position = "bottom",
	}):setup({
		{
			title,
			require('misc.libs.stdlib').force_right(bling.widget.tabbed_misc.titlebar_indicator(c, {
				layout = wibox.layout.fixed.horizontal,
				bg_color_focus = beautiful.titlebar_fg_focus,
				bg_color  = "#00000000",
				widget_template = {
					{{
						{
							widget = wibox.container.background,
							id = 'bg_role',
							forced_width = dpi(8),
							forced_height = dpi(8),
							shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,3) end,
						},
						widget = wibox.container.margin,
						margins = dpi(3)
					},
					widget = wibox.container.margin,
					margins = dpi(2),
					color = beautiful.titlebar_fg_focus
				}, 
				widget = wibox.container.constraint,
				width = 32,
				height = 32,
				shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,3) end,
			},
			})),
			layout = wibox.layout.align.horizontal,
		},
		buttons = titlebar_buttons,
		widget = wibox.container.margin,
		right = dpi(5),
		left = dpi(5)
	})
end)
