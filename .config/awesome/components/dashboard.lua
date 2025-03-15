local std = require('platform.stdlib')
-- local surface_filters = require('platform.libs.surface_filters')
local components = {}

local dashboard = nil
local update_fns = {}

local blur_bg = function(v)
		if v then
			awful.spawn.easy_async("convert x:root -gaussian-blur 0x2 -evaluate multiply 0.75 /tmp/blur-screenshot.png", function()
				dashboard.bgimage = gears.surface.load_uncached('/tmp/blur-screenshot.png')
				dashboard.visible = v
			end)
		else
			dashboard.visible = v
		end
	end

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
		widget = { children, widget = wibox.container.background, bg = std.color.hexa('#181818', 0.75) },
		visible = false,
		ontop = true,
		fg = beautiful.wibar_bg,
		placement = awful.placement.maximize,
		-- type = 'menu',
		-- bgimage = '/tmp/blur-screenshot.png',
		bg = std.color.rgba(0, 0, 0, 0.25),
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
			-- table.insert(update_fns, blur_bg)
		end

		for i, fn in ipairs(update_fns) do
			fn(not dashboard.visible)
		end

		dashboard.visible = not dashboard.visible
	end,
}
