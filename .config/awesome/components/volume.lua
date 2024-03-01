return function(volume)
	local sign = "+"
	if volume < 0 then
		sign = "-"
		volume = volume * -1
	end
	awful.spawn("amixer sset 'Master' " .. tostring(volume) .. "%" .. sign)
	require("components.splashmsg")({
		{
			{
				widget = wibox.widget.textbox,
				font = "CozetteVector 100",
				text = "",
				align = "center"
			},
			{
				widget = wibox.widget.progressbar,
				max_value = 100,
				color = '#f0f0f0',
				background_color = require('platform.stdlib').color.darken("#f0f0f0", 64),
				value = volume,
				forced_height = 16,
				forced_width = 280,
				shape = require('platform.stdlib').rounded,
			},
			spacing = 16,
			layout = wibox.layout.fixed.vertical
		},
		widget = wibox.container.margin,
		margins = 16
	})
end
