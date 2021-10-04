-- TODO: Setup keygrabber

-- Imports
local tbl_contains = require("misc.libs.stdlib").contains
local function draw(tag)
	local geo = tag.screen:get_bounding_geometry({
		honor_padding = true,
		honor_workarea = true,
	})
	local scale = 0.15
	local margin = 0
	local width = scale * geo.width + margin * 2
	local height = scale * geo.height + margin * 2
	local widget = wibox.widget({
		{
			require("misc.libs.bling.widget.tag_preview").draw_widget(tag, {
				scale = scale,
				widget_border_radius = 3,
				client_border_radius = 3,
				client_opacity = 0.8,
				client_bg = "#fffaf3",
				client_border_color = "#f2e9de",
				client_border_width = 2,
				widget_bg = "#faf4ed",
				widget_border_color = "#ffffff",
				widget_border_width = 0,
				margin = margin,
			}, geo),
			widget = wibox.container.constraint,
			forced_width = width,
			forced_height = height,
			buttons = awful.button({}, mouse.LEFT, function()
				tag:view_only()
			end),
		},
		{
			widget = wibox.widget.textbox,
			markup = '<span foreground="#575279">'
				.. (tag.selected and "★" or " ")
				.. " Tag "
				.. tag.index
				.. ": "
				.. tag.name
				.. "</span>",
			font = "UnifontMedium Nerd Font 13",
			id = "tag_title",
		},
		layout = wibox.layout.fixed.vertical,
		spacing = dpi(8),
	})

	tag:connect_signal("property::selected", function()
		widget:get_children_by_id("tag_title")[1].markup = '<span foreground="#575279">'
			.. (tag.selected == true and "★" or " ")
			.. " Tag "
			.. tag.index
			.. ": "
			.. tag.name
			.. "</span>"
	end)

	return widget
end

-- Settings
local slots = 1
local rows = 4
local layout_v = wibox.widget({
	vertical_spacing = dpi(16),
	layout = wibox.layout.grid.horizontal,
	forced_num_rows = rows,
	forced_num_cols = slots,
	homogeneous = true,
})

-- Layout
local tags = awful.screen.focused().tags
local iter = 0

for _, tag in ipairs(tags) do
	local item_idx = #layout_v.children + 1
	local old = draw(tag)
	local upd = function()
		local new = draw(tag)
		layout_v:replace_widget(old, new)
		old = new
	end
	layout_v:add(old)

	local attach_client = function(client)
		local upd_client = function()
			if tbl_contains(client:tags(), tag) then
				upd()
			end
		end
		-- On moving
		client:connect_signal("property::x", upd_client)
		client:connect_signal("property::y", upd_client)
		-- On resize
		client:connect_signal("property::width", upd_client)
		client:connect_signal("property::height", upd_client)
	end

	-- Listen to clients being added or removed from the tag
	tag:connect_signal("tagged", function(_, c)
		attach_client(c)
		upd()
	end)
	tag:connect_signal("untagged", upd)

	-- Attach to existing clients
	for _, client in ipairs(tag:clients()) do
		attach_client(client)
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
	bg = "#f2e9de",
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
	if not overview.visible then
		collectgarbage("collect")
	end
end
