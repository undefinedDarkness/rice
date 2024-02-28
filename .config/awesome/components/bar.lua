local cl = require("platform.stdlib") --.color
-- vim:fdm=marker:
awful.screen.connect_for_each_screen(function(s)
	local layout_no = wibox.widget.textbox()
	layout_no.text = 0 -- s.selected_tag.index
	layout_no.valign = "center"
	layout_no.align = "left"
	layout_no:buttons(awful.button({}, mouse.LEFT, function()
		awful.tag.viewnext(mouse.screen)
	end))

	local clock = awful.widget.textclock("%H:%M")
	clock.align = "center"

	clock:connect_signal("mouse::enter", function()
		clock.format = "(%a) %d/%m/%y %H:%M"
	end)

	clock:connect_signal("mouse::leave", function()
		clock.format = "%H:%M"
	end)
	--
	awful.screen.focused():connect_signal("tag::history::update", function()
		layout_no.markup = " " .. s.selected_tag.name
	end)

	local nowPlaying = wibox.widget.textbox()
	nowPlaying.align = "center"

	local playPrev = wibox.widget.textbox("󰒮")
	playPrev:buttons(awful.button({}, mouse.LEFT, function() 
		playerctl:previous()
	end))
	playPrev.visible = false
	local playNext = wibox.widget.textbox("󰒭")
	playNext:buttons(awful.button({}, mouse.LEFT, function ()
		playerctl:next()
	end))
	playNext.visible = false

	local playerLayout = wibox.widget {
		playPrev,
		nowPlaying,
		playNext,
		spacing = 6,
		layout = wibox.layout.fixed.horizontal
	}

	playerLayout:connect_signal("mouse::enter", function ()
		playPrev.visible = true
		playNext.visible = true
	end)

	playerLayout:connect_signal('mouse::leave', function()
		playPrev.visible=false
		playNext.visible=false
	end)

	local lastPlayed-- {{{
	playerctl:connect_signal("metadata", function(_, title)
		nowPlaying.markup = "<span>󰎆 <i>" .. title .. "</i></span>"
		lastPlayed = nowPlaying.markup
	end)

	playerctl:connect_signal("playback_status", function(_, playing)
		if not playing then
			lastPlayed = nowPlaying.markup
			nowPlaying.markup = "<span>Paused</span>"
		else
			nowPlaying.markup = lastPlayed
		end
	end)

	nowPlaying:buttons(awful.button({}, mouse.LEFT, function()
		playerctl:play_pause()
	end))-- }}}

	s.mywibar = awful.wibar({
		position = "left",
		screen = s,
		ontop = false,
		type = "dock",
	})
	s.mywibar:setup({{
		layout_no,
		playerLayout,
		{
			clock,
			{ wibox.widget.systray(), widget = wibox.container.margin, margins = 2 },
			layout = wibox.layout.fixed.horizontal,
		},
		layout = wibox.layout.align.vertical,
		expand = "none",
	}, widget = wibox.container.margin, margins = 8})
end)
