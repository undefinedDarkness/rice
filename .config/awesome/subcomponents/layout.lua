local std = require('misc.libs.stdlib')
local contain_image = std.contain_image

local layout_button = function(image, cb)
	local widget = contain_image(
		gears.color.recolor_image(_config_dir .. '/theme/assets/layouts/' .. image .. '.png', '#c8bAA4'),
		32,
		32,
		{ resize = false, scaling_quality = 'nearest' }
	)
	widget:buttons(awful.button({}, mouse.LEFT, cb))
	return widget
end

local client = nil
local function setup_grid()
	local widget = wibox.widget({
		layout = wibox.layout.grid.horizontal,
		fixed_num_cols = 3,
		fixed_num_rows = 2,
		id = 'grid',
		horizontal_spacing = dpi(8),
		vertical_spacing = dpi(8),

		-- Left - Center - Right
		layout_button('left', function()
			awful.placement.top_left(client, { honor_workarea = true, honor_padding = true })
			awful.placement.stretch_down(client, { honor_workarea = true, honor_padding = true })
		end),
		layout_button('center', function()
			awful.placement.top(client, { honor_workarea = true, honor_padding = true })
			awful.placement.stretch_down(client, { honor_workarea = true, honor_padding = true })
		end),
		layout_button('right', function()
			awful.placement.top_right(client, { honor_workarea = true, honor_padding = true })
			awful.placement.stretch_down(client, { honor_workarea = true, honor_padding = true })
		end),
	})

	local update_layouts = nil
	update_layouts = function()
		local current = awful.layout.get(mouse.screen)
		for i, layout in ipairs(awful.layout.layouts) do
			local image = layout == current
					and gears.color.recolor_image(beautiful['layout_' .. layout.name], '#d9b27c')
				or gears.color.recolor_image(beautiful['layout_' .. layout.name], '#c8bAA4')

			local x = contain_image(image, 32, 32)
			x:buttons(awful.button({}, mouse.LEFT, function()
				awful.layout.set(layout)
				update_layouts()
			end))

			widget:add_widget_at(x, 2, i)
		end
	end
	update_layouts()

	return widget
end

local window = awful.popup({
	visible = false,
	widget = {
		{
			setup_grid(),
			widget = wibox.container.margin,
			margins = dpi(8),
		},
		widget = wibox.container.background,
		bg = '#252221',
	},
	ontop = true,
	hide_on_right_click = true,
})

return function(c)
	client = c
	awful.placement.under_mouse(window)
	std.only_popup(window, not window.visible)
end
