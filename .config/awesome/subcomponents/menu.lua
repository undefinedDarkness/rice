local sections = {
	{
		name = "Shortcuts",
		submenu = true,
		highlight = beautiful.fg_dark_blue,
		{ name = "AWM Config", exe = [[ cd $XDG_CONFIG_HOME/awesome ; st ]] },
		{ name = "NVIM Config", exe = [[ cd $XDG_CONFIG_HOME/nvim ; st ]] },
		{ name = "Screenshot", exe = [[ import -frame -border -window root ~/screenshot.png ]] },
		{
			name = "Screenshot [W]",
			exe = [[ import -frame -border -window $(xwininfo | grep -Eo '0x[0-9]+' -m1) ~/screenshot.png ]],
		},
	},
	{
		name = "Applications",
		{ name = "Terminal", exe = "st", icon = "" },
		{ name = "WWW ", exe = "firefox-esr", icon = "" },
	},
}
local window = nil
local function setup_section_header(section, layout)
	return {
		{
			{
				{
					{
						widget = wibox.widget.textbox,
						markup = '<span weight="bold">  ' .. section.name .. "</span>",
						align = "left",
					},
					widget = wibox.container.margin,
					top = dpi(5),
					bottom = dpi(5),
				},
				widget = wibox.container.background,
				bg = beautiful.bg_base,
				buttons = awful.button({}, mouse.LEFT, function()
					layout.visible = not layout.visible -- TODO: animations
				end),
			},
			widget = wibox.container.margin,
			left = dpi(10),
		},
		bg = section.highlight or beautiful.fg_dark_red,
		widget = wibox.container.background,
	}
end

local function setup_section_item(section, item)
	return {
		{
			widget = wibox.widget.textbox,
			align = "left", -- "center",
			markup = item.name,
			font = "UnifontMedium Nerd Font 14",
			buttons = awful.button({}, mouse.LEFT, function()
				if type(item.exe) == "string" then
					awful.spawn.with_shell(item.exe)
				elseif type(item.exe) == "function" then
					item.exe()
				end
				window.visible = false
			end),
		},
		widget = wibox.container.margin,
		top = idx == 1 and dpi(3) or 0,
		left = dpi(5),
		bottom = idx == #section and dpi(5) or 0,
	}
end

local function setup_section(section)
	local layout = wibox.widget({
		layout = wibox.layout.fixed.vertical,
		visible = not section.submenu,
	})
	for idx, item in ipairs(section) do
		layout:add(setup_section_item(section, item))
	end
	return layout
end

local function setup_root_layout()
	local layout = wibox.widget({
		layout = wibox.layout.fixed.vertical,
	})

	for _, section in ipairs(sections) do
		local l = setup_section(section)
		layout:add(setup_section_header(section, l))
		layout:add(l)
	end

	return layout
end

-- Setup window
window = awful.popup({
	visible = false,
	widget = {
		setup_root_layout(),
		widget = wibox.container.background,
		fg = beautiful.fg_subtle,
	},
	minimum_width = 150,
	ontop = true,
	border_width = 0,
	bg = beautiful.bg_overlay,
})

return function()
	local x = not window.visible
	if x then
		awful.placement.under_mouse(window)
	end
	window.visible = x
end
