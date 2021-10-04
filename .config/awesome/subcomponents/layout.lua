function contain_image(i, w, h, cb)
	return wibox.widget({
		{
			widget = wibox.widget.imagebox,
			image = i,
			scaling_quality = "nearest",
			resize = false,
		},
		widget = wibox.container.constraint,
		width = w or 200,
		height = h or w or 200,
		buttons = cb and awful.button({}, mouse.LEFT, cb) or nil,
	})
end
local client = nil
local widget = wibox.widget({
	{
		{
			{
				layout = wibox.layout.grid.horizontal,
				fixed_num_rows = 2,
				fixed_num_cols = 4,
				id = "grid",
				horizontal_spacing = dpi(8),
			},
			{
				layout = wibox.layout.fixed.horizontal,
				contain_image(_config_dir .. "/theme/assets/layouts/left.png", 32, 32, function()
					awful.placement.top_left(client, { honor_workarea = true, honor_padding = true })
					awful.placement.stretch_down(client, { honor_workarea = true, honor_padding = true })
				end),
				contain_image(_config_dir .. "/theme/assets/layouts/center.png", 32, 32, function()
					awful.placement.top(client, { honor_workarea = true, honor_padding = true })
					awful.placement.stretch_down(client, { honor_workarea = true, honor_padding = true })
				end),
				contain_image(_config_dir .. "/theme/assets/layouts/right.png", 32, 32, function()
					awful.placement.top_right(client, { honor_workarea = true, honor_padding = true })
					awful.placement.stretch_down(client, { honor_workarea = true, honor_padding = true })
				end),
				spacing = dpi(8),
			},
			widget = wibox.layout.fixed.vertical,
			spacing = dpi(8),
		},
		widget = wibox.container.margin,
		margins = dpi(8),
	},
	widget = wibox.container.background,
	bg = "#f2e9de",
})

local function update()
	widget:get_children_by_id("grid")[1]:reset()
	local current = awful.layout.get(mouse.screen)
	for _, layout in ipairs(awful.layout.layouts) do
		local image = layout == current and gears.color.recolor_image(beautiful["layout_" .. layout.name], "#635E80")
			or beautiful["layout_" .. layout.name]
		local x = contain_image(image, 32, 32, function()
			awful.layout.set(layout)
			update()
		end)
		widget:get_children_by_id("grid")[1]:add(x)
	end
end
update()

local window = awful.popup({
	visible = false,
	widget = widget,
	ontop = true,
	hide_on_right_click = true,
	shape = function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, 5)
	end,
})

return function(c)
	client = c
	awful.placement.under_mouse(window)
	window.visible = not window.visible
end
