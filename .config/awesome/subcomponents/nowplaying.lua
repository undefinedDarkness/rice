
local nowPlaying = wibox.widget.textbox()
nowPlaying.align = "center"
nowPlaying.font = "Recursive Sans Linear Static 15"
nowPlaying.forced_width = 250
nowPlaying.forced_height = 32

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
	{
		{
			playPrev,
			nowPlaying,
			playNext,
			spacing = 6,
			layout = wibox.layout.fixed.horizontal
		},
		-- playerProgress,
		layout = wibox.layout.fixed.vertical
	}, widget = wibox.container.margin, margins = 0 
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
	nowPlaying.markup = "<span>Playing <i>" .. title .. "</i></span>"
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

playerctl:connect_signal("position", function(done, full, player)
	require("naughty").notify { text = done / full }
end)

nowPlaying:buttons(awful.button({}, mouse.LEFT, function()
	playerctl:play_pause()
end))-- }}}

return playerLayout
