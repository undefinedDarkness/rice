local splash_active = false

return function(content)
	local popup = awful.popup {
		visible = true,
		ontop = true,
		widget = content,
		bg = '#181818af',
		fg = '#f0f0f0',
		type = 'splash',
		shape = require('platform.stdlib').rounded(16),
		placement = function(d) awful.placement.bottom(d, { margins = { bottom = 40 } }) end
	}

	gears.timer.start_new(3, function()
		-- TODO: Fade effect
		popup.visible = false
		return false	
	end)
end
