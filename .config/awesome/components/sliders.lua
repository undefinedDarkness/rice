local wibox = require("wibox")
local awful = require("awful")

-- TODO: ANIMATE

local vol_slider = wibox.widget({
	bar_shape = gears.shape.rounded_bar,
	bar_height = 10,
	minimum = 0,
	maximum = 100,
	handle_width = 20,
	bar_color = "#45403d",
	bar_active_color = "#e78a4e",
	handle_color = "#fafafa",
	handle_shape = gears.shape.circle,
	widget = wibox.widget.slider,
})

local vol_popup = awful.popup({
	visible = false,
	bg = "#32302f",
	-- border_width = 1,
	-- border_color = '#45403d',
	placement = function(c)
		awful.placement.bottom(c, { honor_workarea = true, honor_padding = true, margins = { bottom = 50 } })
	end,
	ontop = true,
	shape = function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, 5)
	end,
	widget = {
		{
			{
				font = "Arimo Nerd Font 18",
				widget = wibox.widget.textbox,
				markup = '<span color="#fafafa">奔</span>', -- TODO: Change dynmically!
				align = "center",
				valign = "center",
			},
			{
				{
					vol_slider,
					widget = wibox.container.rotate,
					-- direction = "east",
				},
				widget = wibox.container.constraint,
				height = 50,
				width = 200,
			},
			spacing = 8,
			layout = wibox.layout.fixed.horizontal,
		},
		widget = wibox.container.margin,
		left = 10,
		right = 10,
	},
})

local vol_close_timer = gears.timer({
	timeout = 5,
	callback = function()
		vol_popup.visible = false
		vol_close_timer:stop()
	end,
})

vol_slider:connect_signal("property::value", function()
	vol_close_timer:again()
	awesome.spawn("amixer -M set 'Master' " .. vol_slider.value .. "%")
end)

awful.spawn.easy_async_with_shell([[amixer get Master | grep '\d{2}(?=%\])' -Po]], function(vol)
	vol_slider.value = tonumber(vol)
end)

local brightness_slider = wibox.widget({
	bar_shape = gears.shape.rounded_bar,
	bar_height = 10,
	minimum = 0,
	maximum = 100,
	handle_width = 20,
	bar_color = "#45403d",
	bar_active_color = "#89b482",
	handle_color = "#fafafa",
	handle_shape = gears.shape.circle,
	widget = wibox.widget.slider,
})

local brightness_popup = awful.popup({
	visible = false,
	bg = "#32302f",
	placement = function(c)
		awful.placement.bottom(c, {
			honor_workarea = true,
			honor_padding = true,
			margins = { bottom = 50 },
		})
	end,
	ontop = true,
	shape = function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, 5)
	end,
	widget = {
		{
			{
				font = "Arimo Nerd Font 18",
				widget = wibox.widget.textbox,
				markup = '<span color="#fafafa">奔</span>', -- TODO: Change dynmically!
				align = "center",
				valign = "center",
			},
			{
				{
					vol_slider,
					widget = wibox.container.rotate,
					-- direction = "east",
				},
				widget = wibox.container.constraint,
				height = 50,
				width = 200,
			},
			spacing = 8,
			layout = wibox.layout.fixed.horizontal,
		},
		widget = wibox.container.margin,
		left = 10,
		right = 10,
	},
})

local brightness_close_timer = gears.timer({
	timeout = 5,
	callback = function()
		brightness_popup.visible = false
		bright_close_timer:stop()
	end,
})

brightness_slider:connect_signal("property::value", function()
	brightness_close_timer:again()
	awesome.spawn("light -S " .. brightness_slider.value)
end)

awful.spawn.easy_async_with_shell([[light -G]], function(vol)
	brightness_slider.value = tonumber(vol)
end)

return {
	volume = function()
		vol_close_timer:again()
		if not vol_popup.visible then
			vol_popup.visible = true
		end
	end,
	brightness = function()
		brightness_close_timer:again()
		if not brightness_popup.visible then
			brightness_popup.visible = true
		end
	end,
}
