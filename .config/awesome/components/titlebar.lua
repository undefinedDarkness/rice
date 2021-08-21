local B = require("subcomponents.titlebar")
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
--[[
	local tabbed_icons = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		spacing = dpi(4),
	})

	awesome.connect_signal("bling::tabbed::update", function(group)
		local focused = group.clients[group.focused_idx]
		if require("misc.libs.stdlib").contains(group.clients, c) then
			tabbed_icons:reset()
			for idx, _c in ipairs(group.clients) do
				tabbed_icons:add(wibox.widget({
					{
						{
							{
								client = _c,
								widget = awful.widget.clienticon,
								forced_width = 20,
								forced_height = 20,
							},
							widget = wibox.container.margin,
							margins = dpi(4),
						},
						widget = wibox.container.background,
						bg = _c == focused and "#32302f" or "#00000000",
						shape = require("misc.libs.stdlib").rounded(5),
						buttons = awful.button({}, mouse.LEFT, function()
							bling.module.tabbed.switch_to(group, idx)
						end),
					},
					widget = wibox.container.place,
					halign = "center",
					valign = "center",
				}))
			end
		end
	end)
]]--
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

	awful.titlebar(c, {
		size = 44,
		bg_normal = beautiful.bg_normal,
		bg_focus = beautiful.bg_normal,
	}):setup({
		{
			require('bling.widget.tabbed_misc').titlebar_indicator(c),--tabbed_icons,
			widget = wibox.container.margin,
			left = dpi(12),
		},
		main,
		{
			-- Right
			B.custom_minimized_button(c),
			B.custom_maximized_button(c),
			B.custom_close_button(c),
			layout = wibox.layout.fixed.horizontal,
		},
		layout = wibox.layout.align.horizontal,
	})
end)
