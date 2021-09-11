local force_center = require("misc.libs.stdlib").force_center

return function(s)
	return wibox.widget({
		awful.widget.tasklist({
			screen = s,
			filter = awful.widget.tasklist.filter.currenttags,
			style = {
				bg_focus = "#282a2e",
				bg_normal = "#00000000",
				shape = function(cr, w, h)
					gears.shape.rounded_rect(cr, w, h, 5)
				end,
			},
			layout = {
				layout = wibox.layout.fixed.horizontal,
				spacing = 8,
			},
			-- TODO: Center client!
			widget_template = {
				{
					{
						{
							widget = wibox.widget.imagebox,
							id = "icon_role",
						},
						widget = wibox.container.constraint,
						width = 20,
						height = 20,
					},
					widget = wibox.container.margin,
					margins = 5,
				},
				widget = wibox.container.background,
				id = "background_role",
				update_callback = require("misc.libs.bling.widget.tabbed_misc").custom_tasklist,
			},
			buttons = {
				awful.button({}, 1, function(c)
					c:activate({ context = "tasklist", action = "toggle_minimization" })
				end),
				awful.button({}, 3, function()
					awful.menu.client_list({ theme = { width = 250 } })
				end),
				awful.button({}, 4, function()
					awful.client.focus.byidx(-1)
				end),
				awful.button({}, 5, function()
					awful.client.focus.byidx(1)
				end),
			},
		}),
		widget = wibox.container.background,
		bg = "#1d1f21",
		shape = function(cr, w, h)
			gears.shape.rounded_rect(cr, w, h, 5)
		end,
	})
end
