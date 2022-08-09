local rubato = require('platform.libs.rubato')
local playerctl = bling.signal.playerctl.cli()
local stdlib = require("platform.stdlib")

local album_art = wibox.widget.imagebox()
album_art.image = _config_dir .. '/theme/assets/elevator.jpg'
album_art.upscale = true
album_art.scaling_quality = 'best'

-- local title_w = wibox.widget.textbox('Nothing Playing')
-- title_w.valign = 'bottom'

local fmt = stdlib.formatter("foreground='white' font='IBM Plex Sans 30'")
local play_pause = wibox.widget.textbox("")
play_pause.markup = fmt("⏵")
play_pause.align = "center"

play_pause:buttons(awful.button({},1,function() playerctl:play_pause()   end))
playerctl:connect_signal('metadata', function(_, title, artist, album_path)
	album_art.image = album_path
	-- title_w.markup = "<span foreground='#ffffff' font='IBM Plex Sans 20'> " .. title .. '</span>'
end)

playerctl:connect_signal("playback_status", function(_, playing)
	if playing == false then 
		play_pause.markup = fmt("⏵")
	else
		play_pause.markup = fmt("⏸")
	end
end)

local function app_btn(n, launch) 
	return {
		widget = wibox.container.background,
		bg = '#fafafa',
		{
			widget = wibox.container.margin,
			margins = 12,
			buttons = awful.button({}, 1, launch or function() 
				awful.spawn(n)
			end),
			{
				widget = wibox.widget.imagebox,
				image = stdlib.gtk_lookup_icon(n, nil) or "",
				forced_width = 48,
				forced_height = 48
			},
		},
	}
end

local window = wibox({
	width = 1,
	visible = false,
	widget = {
		{
			album_art,
			{
				widget = wibox.container.background,
				bg = '#00000066',
			},
			{
				{
					widget = wibox.widget.textbox,
					align = 'right',
					markup = fmt("⏮"),
					buttons = awful.button({}, 1, function() playerctl:previous() end)
				},
				play_pause,
				{
					align = 'left',
					widget = wibox.widget.textbox,
					markup = fmt("⏭"),
					buttons = awful.button({}, 1, function() playerctl:next() end)
				},
				spacing = 20,
				layout = wibox.layout.flex.horizontal,
			},
			layout = wibox.layout.stack,
		},
		{{
			layout = wibox.layout.grid,
			forced_num_cols = 2,
			spacing = 16,
			forced_num_cols = 2,
			app_btn("firefox"),
			app_btn("code"),
			app_btn("xterm"),
			app_btn("discord", function()
				awful.spawn("firefox https://discord.com/app")
			end)
		},
	widget=wibox.container.margin,margins=10},
		layout = wibox.layout.fixed.vertical,
	},
	bg = '#dadada',
	ontop = true,
})

awful.placement.maximize_vertically(window)

local bar = mouse.screen.mywibar
local ani = rubato.timed({
	duration = 0.5,
	pos = 1,
	awestore_compat = true,
	subscribed = function(pos)
		window.width = pos
		bar.x = pos - 1
	end,
})

ani.ended:subscribe(function()
	if window.width == 1 then
		window.visible = false
	end
end)

return function()
	if window.visible == true then
		ani.target = 1
	else
		window.visible = true
		ani.target = 180
	end
end
