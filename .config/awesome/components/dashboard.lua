local std = require('platform.stdlib')
local components = {}

local dashboard = nil
local update_fns = {}

function create()
	local children = {
		layout = wibox.layout.stack,
	}

	for i, component in ipairs(components) do
		local w = component
		table.insert(w, w.widget)
		w.widget = wibox.container.place
		if w.update then
			table.insert(update_fns, component.update)
		end
		table.insert(children, w)
	end

	return awful.popup({
		widget = children,
		visible = false,
		ontop = true,
		fg = beautiful.wibar_bg,
		placement = awful.placement.maximize,
		bg = std.color.hexa('#181818', 0.75),
	})
end

return {
	register = function(popup)
		table.insert(components, popup)
	end,
	register_update = function(fn)
		table.insert(update_fns, fn)
	end,
	toggle = function()
		if dashboard == nil then
			dashboard = create()
			if dashboard == nil then
				require('naughty').notify({ text = 'Failed to create dashboard' })
			end
		end

		for i, fn in ipairs(update_fns) do
			fn(not dashboard.visible)
		end

		dashboard.visible = not dashboard.visible
	end,
}
