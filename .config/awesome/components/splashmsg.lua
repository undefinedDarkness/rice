local rubato = require('platform.libs.rubato')
local stdlib = require('platform.stdlib')
local last = nil
return function(content)
	local popup = awful.popup({
		visible = false,
		ontop = true,
		widget = content,
		bg = '#181818',
		fg = '#f0f0f0',
		type = 'splash',
		shape = require('platform.stdlib').rounded(16),
		placement = function(d)
			awful.placement.bottom(d, { margins = { bottom = 40 } })
		end,
	})

	if last ~= nil then
		last.visible = false
	end
	popup.visible = true
	last = popup

	-- TODO: Tweak easing
	local timer = rubato.timed({
		duration = 3,
		awestore_compat = true,
		subscribed = function(pos)
			popup.opacity = 1 - pos
		end,
	})

	popup:connect_signal('mouse::enter', function()
		timer.target = 0
		timer.pos = 0
	end)

	popup:connect_signal('mouse::leave', function()
		timer.target = 1
	end)

	timer.ended:subscribe(function()
		popup.visible = false
	end)
	timer.target = 1
end
