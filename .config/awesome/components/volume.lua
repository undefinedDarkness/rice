local value = nil
local timer = nil
local C = require('misc.libs.stdlib')
local icon_fnt = 'Noto Sans 15'
local playerctl = bling.signal.playerctl.lib()

local center_box = wibox.widget.textbox('')
center_box.align = 'center'
center_box.valign = 'center'
center_box.font = icon_fnt
center_box:buttons(awful.button({}, 1, function()
	playerctl:play_pause()
end))

local vol_progress = wibox.widget({
	value = value,
	color = '#282828',
	border_color = '#8a8a8a',
	border_width = dpi(15),
	forced_width = 85,
	forced_height = 85,
	widget = wibox.container.radialprogressbar,
	{ { center_box, widget = wibox.container.margin, top = 5 }, widget = wibox.container.background, fg = '#282828' },
})
vol_progress.point = awful.placement.centered

local go_back = wibox.widget.textbox()
go_back.text = '⏮'
go_back.font = icon_fnt
go_back:buttons(awful.button({}, 1, function()
	playerctl:previous()
end))

local go_forward = wibox.widget.textbox()
go_forward.font = icon_fnt
go_forward.text = '⏭'
go_forward:buttons(awful.button({}, 1, function()
	playerctl:next()
end))

-- Force get volume from system
local function update_from_system(inc)
	awful.spawn.easy_async_with_shell(
		([[ amixer -q sset Master %d%%%s; amixer sget Master | grep -Po '\[\K\d+' -m1 ]]):format(
			math.abs(inc),
			inc > 0 and '+' or '-'
		),
		function(o)
			o = o:gsub('\n', '')
			value = tonumber(o)
			-- center_box.text = value .. '%'
			vol_progress.value = value
		end
	)
end

local art = require('misc.libs.backport.imagebox')()
art.align = 'center'
art.resize = true
art.upscale = true
art.forced_width = 180
art.valign = 'center'
art.clip_shape = function(cr, w, h)
	gears.shape.rounded_rect(cr, w, h, 3)
end

local track = 'Nothing Playing'
awful.tooltip({
	objects = { art },
	timer_function = function()
		return track
	end,
})

local popup = awful.popup({
	widget = {
		{ art, widget = wibox.container.constraint, height = 180, width = 180, stratergy = 'min' },
		{
			{
				{
					go_back,
					vol_progress,
					go_forward,
					spacing = dpi(12),
					layout = wibox.layout.fixed.horizontal,
				},
				widget = wibox.container.margin,
				left = 15,
				right = 15,
				top = 8,
				bottom = 8,
			},
			widget = wibox.container.place,
			valign = 'center',
			halign = 'center',
		},
		layout = wibox.layout.align.vertical,
	},
	bg = '#fafafa',
	hide_on_right_click = true,
	ontop = true,
	placement = function(c)
		awful.placement.bottom_right(
			c,
			{ honor_workarea = true, honor_padding = true, margins = { bottom = 25, right = 25 } }
		)
	end,
	visible = false,
})

playerctl:connect_signal('metadata', function(_, title, ___, album_art)
	art.image = album_art
	track = title
end)

playerctl:connect_signal('playback_status', function(_, is_playing)
	if is_playing == false then
		center_box.text = '⏵'
	else
		center_box.text = '⏸'
	end
end)

popup:connect_signal('mouse::enter', function()
	timer:stop()
end)
popup:connect_signal('mouse::leave', function()
	timer:start()
end)

return function(inc)
	update_from_system(inc)
	if popup.visible == false then
		popup.visible = true
		timer = gears.timer.weak_start_new(3, function()
			popup.visible = false
		end)
	else
		timer:again()
	end
end
