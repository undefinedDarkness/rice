local function window_icon(class, title)
	if gears.string.startswith(title, "NVIM:") then
		return ""
	end

	if class == "st-256color" then
		return ""
	end

	if class == "Thunar" then
		return ""
	end

	return ""
end

client.connect_signal("request::titlebars", function(c)
	-- Titlebar Buttons
	local last_left_click
	local last_right_click
	local titlebar_buttons = gears.table.join(
		awful.button({}, mouse.LEFT, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, mouse.RIGHT, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end),
		awful.button({ "Shift" }, mouse.LEFT, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			c.maximized = not c.maximized
		end),
		awful.button({ "Shift" }, mouse.RIGHT, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			require("subcomponents.layout")(c)
		end)
	)

	local icon = wibox.widget.textbox(window_icon(c.class, c.name))
	icon.align = "center"
	icon.valign = "center"
	icon.font = "CozetteVector 14"
	c:connect_signal("property::name", function()
		icon.text = window_icon(c.class, c.name)
	end)

	-- Titlebar Setup!
	awful.titlebar(c, {
		size = dpi(30),
		bg_focus = "#6e6a86",
		bg_normal = "#9893a5",
		position = "left",
	}):setup({
		{
			{
				icon,
				bling.widget.tabbed_misc.titlebar_indicator(c, {
					layout = wibox.layout.fixed.vertical,
					widget_template = {
						widget = wibox.widget.textbox,
						font = "CozetteVector",
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
			--[[{
				widget = wibox.layout.flex.vertical,
				buttons = titlebar_buttons,
			},]]
			layout = wibox.layout.align.vertical,
		},
		buttons = titlebar_buttons,
		widget = wibox.container.margin,
		top = dpi(8),
		bottom = dpi(8),
		right = dpi(2),
	})
end)
