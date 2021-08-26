local get_icon = require("menubar.utils").lookup_icon
local menu_gen = require("menubar.menu_gen")
--menu_gen.all_categories = nil -- Reset categories

local list = wibox.widget({
	layout = wibox.layout.fixed.vertical,
	spacing = dpi(5),
})

local launcher = awful.popup({
	visible = false,
	placement = awful.placement.left + awful.placement.maximize_vertically,
	type = "dock",
	bg = "#282a2e",
	widget = {
		{ list, widget = wibox.container.margin, margins = 8 },
		widget = wibox.container.constraint,
		width = 400,
	},
})

local selected_idx = 1
function update_selected(new_idx)
	if new_idx > #list.children then
		new_idx = 1
	elseif new_idx < #list.children then
		new_inx = #list.children
	end
	-- reset every bg
	for _, elem in ipairs(list.children) do
		elem.bg = "#00000000"
	end
	list.children[new_idx].bg = "#373b41"
	selected_idx = new_idx
	mouse.screen.activetext.text = list.children[new_idx].name
end

-- Each item is { cmdline, icon, name }
menu_gen.generate(function(data)
	for idx, item in ipairs(data) do
		if item.icon then
			list:add(wibox.widget({
				{
					require("misc.libs.stdlib").contain_image(item.icon, 30),
					widget = wibox.container.margin,
					margins = dpi(8),
				},
				widget = wibox.container.background,
				shape = function(cr, w, h)
					gears.shape.rounded_rect(cr, w, h, 5)
				end,
				cmd = item.cmdline,
				name = item.name,
				buttons = awful.button({}, mouse.LEFT, function()
					awesome.spawn(item.cmdline)
					launcher.visible = false
				end),
			}))
		end
	end
	update_selected(1)
end)

function launcher.toggle(l)
	l.visible = not l.visible
	local grabber = nil
	grabber = awful.keygrabber({
		keybindings = {
			{
				{},
				"Up",
				function()
					update_selected(selected_idx - 1)
				end,
			},
			{
				{},
				"Down",
				function()
					update_selected(selected_idx + 1)
				end,
			},
			{
				{ modkey },
				"d",
				function()
					grabber:stop()
				end,
			},
			{
				{},
				"Return",
				function()
					awful.spawn(list.children[selected_idx].cmd)
					grabber:stop()
				end,
			},
		},
		stop_key = "Escape",
		stop_callback = function()
			l.visible = false
			mouse.screen.activetext.text = ""
		end,
	})
	grabber:start()
	-- require("menubar").show()
end

local items = {
	{
		"Terminal",
		function()
			awful.spawn(terminal)
		end,
		_config_dir .. "/theme/assets/terminal.svg",
	},
	{
		"Surf",
		function() end,
		get_icon("firefox"),
	},
}

return {
	qmenu = awful.menu(items),
	launcher = launcher,
}
