local C = require("misc.libs.stdlib")

local M = {}

function M.custom_maximized_button(c)
	local colr = beautiful.bg_good

	local buttons = gears.table.join(awful.button({}, mouse.LEFT, function()
		c.maximized = not state
		state = not state
	end))

	local widget = C.hover_effect({
		{
			{
				nil,
				{
					{
						widget = wibox.container.background,
						forced_width = dpi(4),
						forced_height = dpi(4),
					},
					widget = wibox.container.margin,
					margins = dpi(2),
					id = "icon",
					color = colr,
				},
				nil,
				layout = wibox.layout.align.vertical,
				expand = "none",
			},
			widget = wibox.container.margin,
			left = dpi(16),
			right = dpi(16),
		},
		widget = wibox.container.background,
	}, function(w, m)
		if m then
			w.bg = colr
			w:get_children_by_id("icon")[1].color = "#00000080"
		else
			w.bg = beautiful.transparent
			w:get_children_by_id("icon")[1].color = colr
		end
	end)

	widget:buttons(buttons)
	return widget
end

function M.custom_minimized_button(c)
	-- This only works on right click for some stupid reason
	local buttons = gears.table.join(awful.button({}, mouse.RIGHT, function()
		c.minimized = not c.minimized
	end))

	local colr = beautiful.bg_warning

	local widget = C.hover_effect({
		{
			{
				nil,
				{
					widget = wibox.container.background,
					bg = colr,
					forced_width = dpi(10),
					forced_height = dpi(3),
					id = "icon",
				},
				nil,
				layout = wibox.layout.align.vertical,
				expand = "none",
			},
			widget = wibox.container.margin,
			left = dpi(16),
			top = dpi(5),
			right = dpi(16),
		},
		widget = wibox.container.background,
	}, function(w, m)
		if m then
			w.bg = colr
			w:get_children_by_id("icon")[1].bg = "#00000080"
		else
			w.bg = beautiful.transparent
			w:get_children_by_id("icon")[1].bg = colr
		end
	end)

	widget:buttons(buttons)
	return widget
end

function M.custom_close_button(c)
	local buttons = gears.table.join(awful.button({}, mouse.LEFT, function()
		c:kill()
	end))

	local colr = beautiful.bg_urgent

	local widget = C.hover_effect({
		{
			{
				nil,
				{
					widget = wibox.container.background,
					-- Definately not stolen from java's dots
					shape = function(cr, w, h)
						gears.shape.transform(gears.shape.cross):rotate_at(6.5, 6.5, math.pi / 4)(cr, w, h, w / 5)
					end,
					forced_width = dpi(12),
					id = "icon",
					bg = colr,
					forced_height = dpi(12),
				},
				nil,
				layout = wibox.layout.align.vertical,
				expand = "none",
			},
			widget = wibox.container.margin,
			left = dpi(16),
			right = dpi(16),
		},
		widget = wibox.container.background,
	}, function(w, m)
		if m then
			w.bg = colr
			w:get_children_by_id("icon")[1].bg = "#00000080"
		else
			w.bg = beautiful.transparent
			w:get_children_by_id("icon")[1].bg = colr
		end
	end)

	widget:buttons(buttons)

	return widget
end

return M
