local function window_icon(class, title)
	if gears.string.startswith(title, "NVIM:") then
		return ""
	end

	if class == "st-256color" then
		return ""
	elseif class == "Thunar" then
		return ""
	end

	return ""
end

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

	local icon = wibox.widget.textbox(window_icon(c.class, c.name))
	icon.align = "center"
	icon.valign = "center"
	icon.font = beautiful.titlebar_font
	c:connect_signal("property::name", function()
		icon.text = window_icon(c.class, c.name)
	end)

	-- Titlebar Setup!
	awful.titlebar(c, {
		size = dpi(30),
		bg_focus = beautiful.fg_subtle,
		bg_normal = beautiful.fg_magenta,
		position = "left",
	}):setup({
		{
			{
				icon,
				bling.widget.tabbed_misc.titlebar_indicator(c, {
					layout = wibox.layout.fixed.vertical,
					widget_template = {
						widget = wibox.widget.textbox,
						font = beautiful.titlebar_font,
						valign = "center",
						align = "center",
						id = "bg_role",
						update_callback = function(widget, client, group)
							local focused = group.clients[group.focused_idx]
							widget.text = focused == client and "x" or "○"
						end,
					},
				}),
				spacing = dpi(5),
				layout = wibox.layout.fixed.vertical,
			},
			layout = wibox.layout.align.vertical,
		},
		buttons = titlebar_buttons,
		widget = wibox.container.margin,
		top = dpi(8),
		bottom = dpi(8),
		right = dpi(2),
	})
end)
