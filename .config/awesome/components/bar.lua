local cl = require('platform.stdlib') --.color

awful.screen.connect_for_each_screen(function(s)
	local layout_no = wibox.widget.textbox()
	layout_no.text = 0 -- s.selected_tag.index
	layout_no.valign = 'center'
	layout_no.font = 'JetBrainsMono Nerd Font Bold'
	layout_no.align = 'left'
	layout_no:buttons(awful.button({}, mouse.LEFT, function()
		awful.tag.viewnext(mouse.screen)
	end))

	-- local clock = awful.widget.textclock('%H:%M')
	-- clock.align = 'center'

	-- clock:connect_signal('mouse::enter', function()
	-- 	clock.format = '(%a) %d/%m/%y %H:%M'
	-- end)
	--
	-- clock:connect_signal('mouse::leave', function()
	-- 	clock.format = '%H:%M'
	-- end)
	--
	awful.screen.focused():connect_signal('tag::history::update', function()
		layout_no.markup = ' ' .. s.selected_tag.name
	end)

	local nowPlaying = wibox.widget.textbox()
	nowPlaying.align = 'center'

	local lastPlayed
	playerctl:connect_signal("metadata", function(_,title)
		nowPlaying.markup = "<span color='#4d4d4d'><i>" .. title .. "</i></span>"
		lastPlayed = nowPlaying.markup
	end)

	playerctl:connect_signal("playback_status", function(_,playing)
		if not playing then 
			lastPlayed = nowPlaying.markup
			nowPlaying.markup = "<span color='#4d4d4d'>Paused</span>"
		else
			nowPlaying.markup = lastPlayed
		end
	end)

	nowPlaying:buttons(awful.button({}, mouse.LEFT, function()
		playerctl:play_pause()
	end))



	s.mywibar = awful.wibar({
		position = 'bottom',
		screen = s,
		ontop = true,
		height = 24,
		type = 'dock',
	})
	s.mywibar:setup({
		layout_no,
		nowPlaying,
		{ wibox.widget.systray(), widget = wibox.container.margin, margins = 2 },
		layout = wibox.layout.align.horizontal,
		-- forced_num_cols = 3,
		-- forced_num_rows = 1,
		expand = 'none',
	})
end)
