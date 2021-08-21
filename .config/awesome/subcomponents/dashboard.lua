local M = {}
local C = require("misc.libs.stdlib")

local function fix_wttr_out(x)
	local subs = {
		{ "+", "" },
		{ "-", "" },
		{ "☁️", "<b>摒</b>" },
		{ "🌫", "<b>敖</b>" },
		{ "🌧", "<b>歹</b>" },
		{ "❄️", "<b>流</b>" },
		{ "🌦", "<b>殺</b>" },
		{ "⛅️", "<b>杖</b>" },
		{ "☀️", "<b>滛</b>" },
		{ "🌩", "<b>朗</b>" },
		{ "⛈", "<b>ﭼ</b>" },
		{ "↓", "↙", "←", "↖", "↑", "↗", "→", "↘", "<b>煮 </b>" },
	}

	for _, subl in ipairs(subs) do
		local to_sub = table.remove(subl, #subl)
		for _, sub in ipairs(subl) do
			x = x:gsub(sub, to_sub)
		end
	end
	return x
end

-- Fortune {{{

M.fortune = wibox.widget({
	widget = wibox.widget.textbox,
	font = "Merriweather 11",
	align = "center",
})

awful.spawn.easy_async([[fortune -s]], function(out)
	out = out:gsub("%-%-", "~")
	M.fortune.text = out
end)

-- }}}

--- Clock {{{

M.date = wibox.widget.textclock("%b %d, %a")
M.date.font = "Victor Mono 10"

M.clock = wibox.widget({
	{
		widget = wibox.widget.textbox,
		font = "JetBrains Mono Bold 26",
		id = "main",
	},
	{
		{
			widget = wibox.widget.textbox,
			valign = "top",
			font = "JetBrains Mono 11",
			text = "T",
			id = "super",
			align = "right",
		},
		widget = wibox.container.margin,
		top = 3,
	},
	-- horizontal_offset = dpi(8),
	layout = wibox.layout.fixed.horizontal,
})

gears.timer({
	timeout = 60,
	autostart = true,
	call_now = true,
	callback = function()
		local t = os.date("*t")
		if t.hour < 12 then -- am
			M.clock:get_children_by_id("super")[1].text = "am"
			M.clock:get_children_by_id("main")[1].markup = string.format(
				"<span>%02d</span>:<span>%02d</span>",
				t.hour,
				t.min
			)
		else -- pm
			M.clock:get_children_by_id("super")[1].text = "pm"
			M.clock:get_children_by_id("main")[1].markup = string.format(
				"<span>%02d</span>:<span>%02d</span>",
				t.hour - 12,
				t.min
			)
		end
	end,
})

-- }}}

--	Brightness {{{

M.brightness = wibox.widget({
	{
		handle_shape = gears.shape.circle,
		handle_width = dpi(20),
		id = "slider",
		bar_active_color = "#e78a4e",
		bar_color = beautiful.bg_highlight,
		handle_color = beautiful.fg_focus,
		widget = wibox.widget.slider,
		minimum = 5,
		maximum = 100,
		bar_shape = gears.shape.rounded_bar,
		bar_height = dpi(10),
	},
	widget = wibox.container.rotate,
	direction = "east",
})

M.brightness:get_children_by_id("slider")[1]:connect_signal("property::value", function(v)
	awful.spawn("light -S " .. v.value)
end)

awful.spawn.easy_async([[light]], function(out)
	M.brightness:get_children_by_id("slider")[1].value = tonumber(out)
end)

-- }}}

-- Volume {{{

M.volume_meter = wibox.widget({
	{
		handle_shape = gears.shape.circle,
		handle_width = dpi(20),
		id = "slider",
		bar_active_color = "#89b482",
		bar_color = beautiful.bg_highlight,
		handle_color = beautiful.fg_focus,
		widget = wibox.widget.slider,
		minimum = 5,
		maximum = 100,
		bar_shape = gears.shape.rounded_bar,
		bar_height = dpi(10),
	},
	widget = wibox.container.rotate,
	direction = "east",
})

awful.spawn.easy_async_with_shell([[amixer get Master | grep -Po '\[\K\d+' -m1]], function(vol)
	M.volume_meter:get_children_by_id("slider")[1].value = tonumber(vol)
end)

M.volume_meter:get_children_by_id("slider")[1]:connect_signal("property::value", function(w)
	awful.spawn("amixer set Master " .. w.value .. "%")
end)

-- }}}

-- Quick Access Buttons {{{

function quick_access_btn(icon, action)
	return {
		{
			{
				widget = wibox.widget.imagebox,
				image = require("menubar.utils").lookup_icon(icon),
				resize = true,
				buttons = awful.button({}, mouse.LEFT, function()
					awful.spawn.with_shell(action)
				end),
				forced_width = 24,
				forced_height = 24,
			},
			widget = wibox.container.margin,
			margins = 10,
		},
		widget = wibox.container.background,
		bg = beautiful.bg_normal,
		shape = function(cr, w, h)
			gears.shape.rounded_rect(cr, w, h, 8)
		end,
	}
end

local voyager_txt = wibox.widget({
	widget = wibox.widget.textbox,
	align = "left",
})
awful.spawn.easy_async_with_shell([[ bash $HOME/Documents/Scripts/voyager.sh distance_km ]], function(out)
	--awful.spawn.easy_async_with_shell([[ bash $HOME/Documents/Scripts/voyager.sh constellation ]], function(_o)
	voyager_txt.text = out:gsub("\n", "") .. "km" --.. " @ " .. _o
	--end)
end)

M.voyager = wibox.widget({
	{
		C.force_center({
			{
				widget = wibox.widget.imagebox,
				image = user_home .. "/.config/awesome/theme/voyager.jpg",
				resize = true,
			},
			widget = wibox.container.constraint,
			height = 44,
		}),
		{
			{
				{
					voyager_txt,
					widget = wibox.container.margin,
					margins = 10,
					forced_width = 150,
				},
				widget = wibox.container.constraint,
				height = 34,
			},
			bg = "#1d2021",
			widget = wibox.container.background,
		},
		layout = wibox.layout.fixed.horizontal,
	},
	widget = wibox.container.background,
	shape = C.rounded(8),
})

M.quick_access = wibox.widget({
	quick_access_btn("whatsapp", "firefox -P default-release https://web.whatsapp.com"),
	quick_access_btn(
		"com.github.lainsce.timetable",
		[[ xdg-open "$HOME/Documents/Timetable/$(ls -t ~/Documents/Timetable | head -n1)" ]]
	),
	quick_access_btn("reddit", "firefox -P default-release https://reddit.com/r/unixporn"),

	layout = wibox.layout.flex.horizontal,
	spacing = dpi(8),
})

-- }}}

-- Layout List {{{

M.layouts = awful.widget.layoutlist({
	style = {
		disable_name = true,
		bg_selected = "#3c3836",
		shape_selected = function(cr, w, h)
			gears.shape.rounded_rect(cr, w, h, 3)
		end,
	},
	base_layout = wibox.layout.flex.horizontal,
	widget_template = {
		{
			{
				id = "icon_role",
				forced_height = dpi(20),
				forced_width = dpi(20),
				widget = wibox.widget.imagebox,
			},
			widget = wibox.container.margin,
			margins = dpi(5),
		},
		widget = wibox.container.background,
		id = "background_role",
		forced_width = dpi(24),
		forced_height = dpi(24),
	},
})

-- }}}

-- Weather {{{
M.weather = wibox.widget({
	widget = wibox.widget.textbox,
	text = "Strange",
	font = "Victor Mono 10",
})

awful.spawn.easy_async("curl -s 'wttr.in/" .. beautiful.city .. "?format=%c+%f+%w'", function(out, _, _, _)
	if string.len(out) > 0 then
		out = out:gsub("  ", " ")
		out = out:gsub("\n", "")
		M.weather.markup = fix_wttr_out(out)
	end
end)
-- }}}

--- HARDWARE

M.hardware = {}

local function round_meter(color, icon)
	return wibox.widget({
		{
			widget = wibox.widget.textbox,
			text = icon,
			font = "Arimo Nerd Font 16",
			align = "center",
			forced_width = dpi(60),
			forced_height = dpi(60),
		},
		border_color = "#45403d",
		max_value = 100, -- DONT CHANGE
		min_value = 0,
		border_width = dpi(6),
		color = color,
		widget = wibox.container.radialprogressbar,
	})
end

-- RAM Meter {{{

M.hardware.ram = round_meter(beautiful.bg_good, "")

awesome.connect_signal("system::ram", function(used, total)
	M.hardware.ram:set_value(math.ceil((used / total) * 100))
end)

-- }}}
-- CPU Meter {{{

M.hardware.cpu = round_meter("#7daea3", "﬙")

awesome.connect_signal("system::cpu", function(percentage)
	M.hardware.cpu:set_value(percentage)
end)

-- }}}
-- Harddrive Meter {{{

M.hardware.hdd = wibox.widget({
	{
		{
			widget = wibox.widget.progressbar,
			shape = function(cr, w, h)
				gears.shape.rounded_rect(cr, w, h, 8)
			end,
			max_value = 100,
			min_value = 1,
			id = "bar",
			color = beautiful.bg_warning,
			background_color = "#2D2C2C",
		},
		{
			{
				widget = wibox.widget.textbox,
				text = " ",
				align = "center",
				font = "Arimo Nerd Font 16",
			},
			widget = wibox.container.background,
			fg = beautiful.bg_normal2,
			id = "label",
		},
		layout = wibox.layout.stack,
	},
	widget = wibox.container.rotate,
	forced_height = 40,
	direction = "north",
})

awesome.connect_signal("system::disk", function(used, total)
	local value = math.ceil((used / total) * 100)
	M.hardware.hdd:get_children_by_id("bar")[1]:set_value(value)
	if value < 50 then
		M.hardware.hdd:get_children_by_id("label")[1].fg = beautiful.fg_normal
	end
end)

-- }}}
-- BATTERY {{{

M.hardware.battery = wibox.widget({
	widget = wibox.widget.textbox,
	text = "??",
	font = _nerd_font,
})

local battery_icons = { " ", " ", " ", " ", " ", " ", " ", " ", " ", " " }
awesome.connect_signal("system::battery", function(percentage)
	local index = math.min(math.ceil(percentage / 10) * 10, 100) / 10
	M.hardware.battery:set_text(battery_icons[index])
end)

-- }}}
-- TEMPERATURE {{{

M.hardware.temperature = wibox.widget({
	widget = wibox.widget.textbox,
	text = "??",
	font = _nerd_font,
})
--					   20	 40    60	 80    100
local temp_icons = { " ", " ", " ", " ", " " }

awesome.connect_signal("system::temp", function(avgTemp)
	local icon = ""

	if avgTemp <= 20 then
		icon = temp_icons[1]
	elseif avgTemp <= 40 then
		icon = temp_icons[2]
	elseif avgTemp <= 60 then
		icon = temp_icons[3]
	elseif avgTemp <= 80 then
		icon = temp_icons[4]
	else
		icon = temp_icons[5]
	end

	M.hardware.temperature:set_text(icon)
end)

-- }}}

return M
