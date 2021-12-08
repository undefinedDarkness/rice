local groups = {}

for _, hotkey in ipairs(awful.key.hotkeys) do
	if not groups[hotkey.group] then
		groups[hotkey.group] = {}
	end
	table.insert(groups[hotkey.group], hotkey)
end
-- TODO: Refactor some bits to not use globals
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

groups.User.color = beautiful.fg_blue
groups.awesome.color = beautiful.fg_suble
groups.client.color = beautiful.fg_yellow
-- groups.launcher.color = "#d7827e"
-- groups.screen.color = "#286983"
groups.tag.color = beautiful.fg_dark_red
groups.layout.color = beautiful.fg_inactive

local data = wibox.widget({
	layout = wibox.layout.grid.horizontal,
	fixed_num_cols = 2,
	vertical_spacing = dpi(1),
})
-- local M ={}

local groups_sidebar = wibox.widget({
	layout = wibox.layout.fixed.vertical,
})

local function sidebar_item(name, color)
	return wibox.widget({
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
				update(key)
				update_sidebar(key)
			end),
		},
		widget = wibox.container.background,
		bg = color,
	})
end

local function key_widget(hotkeys, color)
	return {
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
		color = color,
	}
end

local function description_widget(desc, color)
	return {
		{
			{
				widget = wibox.widget.textbox,
				markup = desc,
			},
			widget = wibox.container.margin,
			top = dpi(3),
			bottom = dpi(3),
		},
		widget = wibox.container.margin,
		bottom = dpi(1),
		color = color,
	}
end

function update_sidebar(selected)
	groups_sidebar:reset()
	for key, group in pairs(groups) do
		local name = require("misc.libs.stdlib").title_case(key)
		if selected == key then
			name = "<b>" .. name .. "</b>"
		end
		-- Yeah, I dunno whats going on here with the ternary statement
		groups_sidebar:add(
			sidebar_item(name, group.color or (selected == key and beautiful.fg_inactive or beautiful.fg_subtle))
		)
	end
end
function update(selected)
	data:reset()
	for idx, hotkeys in ipairs(groups[selected]) do
		data:insert_row()
		if hotkeys.mod[1] == "Mod1" then
			hotkeys.mod[1] = "Alt"
		elseif hotkeys.mod[1] == "Mod4" then
			hotkeys.mod[1] = "Super"
		end

		local c = idx ~= #groups[selected] and beautiful.fg_inactive or nil
		data:add(key_widget(hotkeys, c))
		data:add(description_widget(hotkeys.description, c))
	end
end

-- Init
update_sidebar("User")
update("User")

local window = awful.popup({
	placement = awful.placement.centered,
	-- minimum_width= 400,
	widget = {
		{ groups_sidebar, widget = wibox.container.background, bg = beautiful.bg_surface },
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
	bg = beautiful.bg_overlay,
	fg = beautiful.fg_inactive,
	-- hide_on_right_click = true
})

return function()
	window.visible = not window.visible
end
