local std = require('platform.stdlib')
local bling_tagpreview = bling.widget.tag_preview

local widget = wibox.widget({
	spacing = 16,
	layout = wibox.layout.fixed.vertical,
})

function update()
	widget:reset()
	for _, tag in ipairs(root.tags()) do
		local scale = 0.18
		local margin = 2

		local filter_for_tag = function(client, s)
			return std.contains(client:tags(), tag)
		end

		local geo = tag.screen:get_bounding_geometry({
			honor_padding = true,
			honor_workarea = true,
		})

		local max_w = scale * geo.width + margin * 2
		local max_h = scale * geo.height + margin * 2

		widget:add({
			{
				std.add_buttons(
					std.pointer(
						bling_tagpreview.draw_widget(
							tag,
							true,
							scale,
							8,
							8,
							1,
							'#fdbc87',
							'red',
							0,
							'transparent',
							beautiful.wibar_fg,
							0,
							geo,
							margin,
							wibox.widget({
								{
									widget = wibox.widget.imagebox,
									image = mouse.screen.mywall,
									halign = 'center',
									valign = 'center',
								},
								widget = wibox.container.background,
								bg = beautiful.wibar_bg,
							})
						)
					),
					{ awful.button({}, mouse.LEFT, function()
						awful.tag.viewonly(tag)
					end) }
				),
				widget = wibox.container.constraint,
				width = max_w,
				height = max_h,
			},
			spacing = 16,
			layout = wibox.layout.fixed.horizontal,
		})
	end
end
local popup = awful.popup({
	screen = mouse.screen,
	ontop = true,
	visible = false,
	type = 'dock',
	widget = { widget, widget = wibox.container.margin, left = 20, top = 10, bottom = 20, right = 20 },
	-- type = 'splash',
	bg = beautiful.dashboard_bg,
})

bling_tagpreview.enable({
	show_client_content = true,
})


local dashboard_components = {}
return {
	toggle = function()
		if not popup.visible then
			update()
		end
		for i, component in ipairs(dashboard_components) do
			component.ontop = not popup.visible
			component.visible = true
			component.bg = (not popup.visible) and beautiful.dashboard_bg or 'transparent'
			-- component.type = 'normal'
		end
		popup.visible = not popup.visible
	end,
	register = function(popup)
		table.insert(dashboard_components, popup)
	end,
}
