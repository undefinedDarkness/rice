local groups = {}

for _, hotkey in ipairs(awful.key.hotkeys) do
	if not groups[hotkey.group] then
		groups[hotkey.group] = {}
	end
	table.insert(groups[hotkey.group], hotkey)
end

-- Flatten table containing tables of strings
function tbl_flat(tbl)
	local out = {}
	for _, tables in ipairs(tbl) do
		for _, _string in ipairs(tables) do
			table.insert(out, _string)
		end
	end
	return out
end

groups.User.color = "#56949f"
groups.awesome.color = "#6e6a86"
groups.client.color = "#ea9d34"
-- groups.launcher.color = "#d7827e"
-- groups.screen.color = "#286983"
groups.tag.color = "#b4637a"
groups.layout.color = "#9893a5"

local data = wibox.widget({
	layout = wibox.layout.grid.horizontal,
	fixed_num_cols = 2,
	vertical_spacing = dpi(1),
})
local selected = "User"
-- local M ={}

local groups_sidebar = wibox.widget({
	layout = wibox.layout.fixed.vertical,
})

function upd_sidebar()
	groups_sidebar:reset()
	for key, group in pairs(groups) do
		local name = require("misc.libs.stdlib").title_case(key)
		if selected == key then
			name = "<b>" .. name .. "</b>"
		end
		groups_sidebar:add(wibox.widget({
			{
				{
					{
						widget = wibox.widget.textbox,
						markup = '<span foreground="#faf4ed">' .. name .. "</span>",
						font = "UnifontMedium Nerd Font 12",
					},
					widget = wibox.container.rotate,
					direction = "east",
				},
				widget = wibox.container.margin,
				margins = dpi(8),
				buttons = awful.button({}, mouse.LEFT, function()
					selected = key
					upd()
					upd_sidebar()
				end),
			},
			widget = wibox.container.background,
			bg = group.color or (selected == key and "#9893a5" or "#6e6a86"),
		}))
	end
end
function upd()
	data:reset()
	for idx, hotkeys in ipairs(groups[selected]) do
		data:insert_row()
		if hotkeys.mod[1] == "Mod1" then
			hotkeys.mod[1] = "Alt"
		elseif hotkeys.mod[1] == "Mod4" then
			hotkeys.mod[1] = "Super"
		end

		data:add({
			{
				{
					widget = wibox.widget.textbox,
					markup = "<b>" .. table.concat(hotkeys.mod, "</b> + <b>") .. "</b> + " .. table.concat(
						tbl_flat(hotkeys.keys),
						" + "
					),
				},
				widget = wibox.container.margin,
				top = dpi(3),
				bottom = dpi(3),
			},
			widget = wibox.container.margin,
			bottom = dpi(1),
			color = idx ~= #groups[selected] and "#9893a5" or nil,
		})
		data:add({
			{
				{
					widget = wibox.widget.textbox,
					markup = hotkeys.description,
				},
				widget = wibox.container.margin,
				top = dpi(3),
				bottom = dpi(3),
			},
			widget = wibox.container.margin,
			bottom = dpi(1),
			color = idx ~= #groups[selected] and "#9893a5" or nil,
		})
	end
end
upd_sidebar()
upd()
local window = awful.popup({
	placement = awful.placement.centered,
	-- minimum_width= 400,
	widget = {
		{ groups_sidebar, widget = wibox.container.background, bg = "#fffaf3" },
		{
			data,
			widget = wibox.container.margin,
			margins = dpi(12),
			draw_empty = true,
		},
		layout = wibox.layout.fixed.horizontal,
		buttons = awful.button({}, mouse.RIGHT, function(c)
			c.visible = false
		end),
	},
	visible = false,
	bg = "#f2e9de",
	fg = "#575279",
	-- hide_on_right_click = true
})

return function()
	window.visible = not window.visible
	-- window.minimum_width = window.width -- Do not reduce size
end
