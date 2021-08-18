local force_center = require("misc.libs.stdlib").force_center

return function(s)
	return wibox.widget({
		{
			awful.widget.tasklist({
				screen = s,
				filter = awful.widget.tasklist.filter.currenttags,
				style = {
					bg_focus = "#373b41",
					bg_normal = "#00000000",
					shape = function(cr, w, h)
						gears.shape.rounded_rect(cr, w, h, 5)
					end,
				},
				layout = {
					layout = wibox.layout.fixed.horizontal,
					spacing = 8,
				},
				widget_template = {
					{
						{
							widget = awful.widget.clienticon,
							forced_width = 20,
							forced_height = 20,
							id = "client_icon",
						},
						widget = wibox.container.margin,
						margins = 3,
					},
					widget = wibox.container.background,
					id = "background_role",
				},
				create_callback = function(self, c)
					self:get_children_by_id("client_icon")[1].client = c
				end,
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
			widget = wibox.container.margin,
			top = dpi(5),
			right = dpi(8),
			left = dpi(8),
			bottom = dpi(5),
		},
		widget = wibox.container.background,
		bg = "#282a2e",
		shape = function(cr, w, h)
			gears.shape.rounded_rect(cr, w, h, 5)
		end,
	})
end
