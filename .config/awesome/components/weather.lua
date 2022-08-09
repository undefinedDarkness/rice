local weather = wibox.widget.textbox('')
weather.markup = "<span foreground='#b39c7c'>Hello, nes</span>"
weather.font = 'Bungee 20'

awful.spawn.easy_async_with_shell(
	[[curl wttr.in/Panjim?format="Feels+like+%f+w/+%h+humidity" -L -s | tr -d '+-']],
	function(out)
		weather.markup = "<span foreground='#b39c7c'>" .. out:gsub('\n', '') .. '</span>'
	end
)

awful.popup({
	screen = mouse.screen,
	visible = true,
	bg = '#00000000',
	type = 'dock',
	widget = weather,
	placement = function(d)
		awful.placement.bottom(d, { honor_workarea = true, margins = { bottom = 300, right = 25 } })
	end,
})
