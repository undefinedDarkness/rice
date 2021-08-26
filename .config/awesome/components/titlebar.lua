local trim_long_name = require("misc.libs.stdlib").trim_long

client.connect_signal("request::titlebars", function(c)
	local titlewidget = wibox.widget({
		visible = false,
		text = trim_long_name(c.name),
		widget = wibox.widget.textbox,
		font = "Victor Mono Bold Italic 10",
	})
	c:connect_signal("property::name", function(z)
		titlewidget.text = trim_long_name(z.name)
	end)

	local buttons = gears.table.join(
		awful.button({}, mouse.LEFT, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
			titlewidget.visible = true
		end),
		awful.button({}, mouse.RIGHT, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	local main = wibox.widget({
		{
			-- Title
			align = "center",
			widget = titlewidget,
		},
		buttons = buttons,
		layout = wibox.layout.flex.horizontal,
	})
	main:connect_signal("mouse::leave", function()
		titlewidget.visible = false
	end)

	local close_button = awful.titlebar.widget.closebutton(c)
	close_button.forced_height = dpi(24)
	close_button.forced_width = dpi(24)
	close_button.halign = "right"
	close_button.valign = "center"

	awful.titlebar(c, {
		size = dpi(44),
		bg_focus = "#e0e0e0",
		bg_normal = "#373b41",
		position = "top",
	}):setup({
		{
			nil,
			{
				{
					widget = wibox.widget.textbox,
				},
				layout = wibox.layout.flex.horizontal,
				buttons = buttons,
			},
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
