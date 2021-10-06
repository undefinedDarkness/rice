local sections = {
	{
		name = "Shortcuts",
		submenu = true,
		highlight = "#286983",
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

local widget = wibox.widget({
	layout = wibox.layout.fixed.vertical,
})

local window = awful.popup({
	visible = false,
	--placement = awful.placement.under_mouse,
	widget = { { widget, widget = wibox.container.background, fg = "#575279" }, widget = wibox.container.margin },
	minimum_width = 150,
	ontop = true,
	border_width = 0,
	bg = "#f2e9de", -- "#faf4ed"
})
for _, section in ipairs(sections) do
	local layout = wibox.widget({
		layout = wibox.layout.fixed.vertical,
		visible = not section.submenu,
	})

	widget:add({
		{
			{
				{
					{
						widget = wibox.widget.textbox,
						markup = '<span weight="bold">  ' .. section.name .. "</span>",
						align = "left",
						font = "UnifontMedium Nerd Font 14",
					},
					widget = wibox.container.margin,
					top = dpi(5),
					bottom = dpi(5),
				},
				widget = wibox.container.background,
				bg = "#faf4ed", -- "#f2e9de",
				buttons = awful.button({}, mouse.LEFT, function()
					layout.visible = not layout.visible -- TODO: animations
				end),
			},
			widget = wibox.container.margin,
			left = dpi(10),
		},
		bg = section.highlight or "#b4637a",
		widget = wibox.container.background,
	})

	for idx, item in ipairs(section) do
		layout:add({
			{
				-- {
				-- 	widget = wibox.widget.textbox,
				-- 	text = item.icon or "",
				-- 	font="UnifontMedium Nerd Font 14",
				-- },
				-- {
				widget = wibox.widget.textbox,
				align = "left", -- "center",
				markup = '<span foreground="#6e6a86">' .. item.name .. "</span>",
				font = "UnifontMedium Nerd Font 14",
				-- },
				-- spacing = dpi(5),
				buttons = awful.button({}, mouse.LEFT, function()
					awful.spawn.with_shell(item.exe)
					window.visible = false
				end),
				-- layout = wibox.layout.fixed.horizontal
			},
			widget = wibox.container.margin,
			top = idx == 1 and dpi(3) or 0,
			left = dpi(5),
			bottom = idx == #section and dpi(5) or 0,
		})
	end

	widget:add(layout)
end
return function()
	local x = not window.visible
	if x then
		awful.placement.under_mouse(window)
	end
	window.visible = x
end
