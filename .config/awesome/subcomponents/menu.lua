local sections = {
	{
		name = 'Shortcuts',
		-- submenu = true,
		{ name = 'Awesome Config', exe = [[ cd $XDG_CONFIG_HOME/awesome ; st ]] },
		{ name = 'Vim Config', exe = [[ cd $XDG_CONFIG_HOME/nvim ; st ]] },
		{ name = 'Screenshot', exe = [[ import -frame -border -window root ~/screenshot.png ]] },
		{
			name = 'Screenshot [W]',
			exe = [[ import -frame -border -window $(xwininfo | grep -Eo '0x[0-9]+' -m1) ~/screenshot.png ]],
		},
	},
	{
		name = 'Applications',
		{ name = 'Terminal', exe = beautiful.terminal, icon = '' },
		{ name = 'Web Browser', exe = 'firefox-esr', icon = '' },
		{ name = 'File Manager', exe = 'thunar' },
	},
}
local window = nil
local function setup_section_header(section, layout)
	return wibox.widget({
		{
			{
				{
					{
						widget = wibox.widget.textbox,
						markup = '<span weight="bold">  ' .. section.name .. '</span>',
						align = 'left',
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
		},
		bg = beautiful.menu_section_bg,
		widget = wibox.container.background,
	})
end

local function setup_section_item(section, item)
	return wibox.widget({
		{
			widget = wibox.widget.textbox,
			align = 'left', -- "center",
			markup = item.name,
			buttons = awful.button({}, mouse.LEFT, function()
				if type(item.exe) == 'string' then
					awful.spawn.with_shell(item.exe)
				elseif type(item.exe) == 'function' then
					item.exe()
				end
				window.visible = false
			end),
		},
		widget = wibox.container.margin,
		top = dpi(5),
		left = dpi(5),
		bottom = dpi(5),
	})
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
	},
	minimum_width = 150,
	ontop = true,
	hide_on_right_click = true,
	border_width = 0,
	bg = beautiful.menu_bg,
})

return function()
	if window.visible then
		-- Right click on main window, assume that it'll be handled by the keygrabber too
		-- Avoid repeats
		return
	end

	awful.placement.under_mouse(window)
	require('misc.libs.stdlib').only_popup(window, x)
end
