local C = require("misc.libs.stdlib")

local M = {}

function M.custom_close_button(c)
	local buttons = gears.table.join(awful.button({}, mouse.LEFT, function()
		c:kill()
	end))

	local colr = beautiful.bg_urgent

	local widget = C.hover_effect({
		{
			{
				{
					widget = wibox.widget.imagebox,
					image = _config_dir .. "/theme/assets/close.svg",
					forced_width = dpi(20),
					forced_height = dpi(20),
				},
				widget = wibox.container.place,
				halign = "center",
				valign = "center",
			},
			widget = wibox.container.margin,
			right = dpi(10),
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
