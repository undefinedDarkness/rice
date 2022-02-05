-- TODO: keygrabber.
local tbl_contains = require('misc.libs.stdlib').contains

local function tag_preview(tag)
	-- TODO: Make these constants?
	local geo = tag.screen:get_bounding_geometry({
		honor_padding = true,
		honor_workarea = true,
	})
	local scale = 0.15
	local margin = 0
	local width = scale * geo.width + margin * 2
	local height = scale * geo.height + margin * 2

	return {
		require('misc.libs.bling.widget.tag_preview').draw_widget(tag, {
			scale = scale,
			widget_border_radius = 3,
			client_border_radius = 3,
			client_opacity = 0.8,
			client_bg = '#fffaf3',
			client_border_color = '#f2e9de',
			client_border_width = 2,
			widget_bg = '#faf4ed',
			widget_border_color = '#ffffff',
			widget_border_width = 0,
			margin = margin,
		}, geo),
		widget = wibox.container.constraint,
		forced_width = width,
		forced_height = height,
		buttons = awful.button({}, mouse.LEFT, function()
			tag:view_only()
		end),
	}
end

local function tag_label(tag)
	local widget = wibox.widget.textbox()
	local update = function()
		widget.markup = '<span foreground="#575279">'
			.. (tag.selected == true and '★' or ' ')
			.. ' Tag '
			.. tag.index
			.. ': '
			.. tag.name
			.. '</span>'
	end
	tag:connect_signal('property::selected', update)
	update()
	return widget
end

local function tag_widget(tag)
	local widget = wibox.widget({
		tag_preview(tag),
		tag_label(tag),
		layout = wibox.layout.fixed.vertical,
		spacing = dpi(8),
	})

	return widget
end

-- Primary Layout
local layout_v = wibox.widget({
	vertical_spacing = dpi(16),
	layout = wibox.layout.grid.horizontal,
	forced_num_rows = 4,
	forced_num_cols = 1,
	homogeneous = true,
})

-- Initiate
for _, tag in ipairs(awful.screen.focused().tags) do
	local item_idx = #layout_v.children + 1

	local old = tag_widget(tag)
	local update = function()
		local new = tag_widget(tag)
		layout_v:replace_widget(old, new)
		old = new
	end
	layout_v:add(old)

	local attach_to_client = function(client)
		local update_client = function()
			if tbl_contains(client:tags(), tag) then
				update()
			end
		end
		-- On moving
		client:connect_signal('property::x', update_client)
		client:connect_signal('property::y', update_client)
		-- On resize
		client:connect_signal('property::width', update_client)
		client:connect_signal('property::height', update_client)
	end

	-- Listen to clients being added or removed from the tag
	tag:connect_signal('tagged', function(_, c)
		attach_to_client(c)
		update()
	end)
	tag:connect_signal('untagged', update)

	-- Attach to existing clients
	for _, client in ipairs(tag:clients()) do
		attach_to_client(client)
	end
end

-- Overview Window
local overview = awful.popup({
	screen = awful.screen.focused(),
	visible = false,
	widget = {
		{
			layout_v,
			layout = wibox.layout.fixed.vertical,
		},
		widget = wibox.container.margin,
		left = dpi(16),
		right = dpi(16),
		top = dpi(20),
		bottom = dpi(20),
	},
	-- type = 'dock',
	bg = '#f2e9de',
	placement = function(c)
		(awful.placement.left + awful.placement.maximize_vertically)(c, {
			honor_workarea = true,
			honor_padding = true,
		})
	end,
})

return function(toggle)
	-- print("Overview!")
	overview.visible = not overview.visible
end
