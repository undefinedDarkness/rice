bling.signal.playerctl.enable()
local C = require("misc.libs.stdlib")

-- Playerctl Image Widget {{{
local playerctl_image = wibox.widget({
	widget = wibox.widget.imagebox,
	image = beautiful.playerctl_default,
	resize = true,
	valign = "center",
	halign = "center",
})
-- }}}

-- Playerctl Control Button {{{
local playerctl_btn = wibox.widget({
	widget = wibox.widget.textbox,
	font = "Arimo Nerd Font 40",
	align = "center",
	valign = "center",
	buttons = awful.button({}, mouse.LEFT, function()
		awful.spawn("playerctl play-pause")
	end),
})
-- }}}
-- Playerctl Tooltip {{{
local playerctl_title = wibox.widget({
	font = "Victor Mono Italic 11",
	ellipsize = "none",
	align = "center",
	text = "Music",
	widget = wibox.widget.textbox,
})
-- }}}

-- Playerctl Window {{{
local playerctl_window = awful.popup({
	hide_on_right_click = true,
	screen = mouse.screen,
	bg = beautiful.transparent,
	shape = function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, 5)
	end,
	ontop = true,
	border_width = 1,
	border_color = beautiful.bg_lighter,
	type = "splash",
	visible = false,
	widget = wibox.widget({
		{
			{ playerctl_image, widget = wibox.container.constraint, height = 200 },
			playerctl_btn,
			layout = wibox.layout.stack,
		},
		{
			{
				playerctl_title,
				widget = wibox.container.margin,
				margins = dpi(5),
				forced_height = 30,
			},
			fg = beautiful.fg_focus,
			widget = wibox.container.background,
			bg = beautiful.bg_normal2,
		},
		layout = wibox.layout.fixed.vertical,
	}),
	placement = function(x)
		awful.placement.bottom_left(x, {
			honor_workarea = true,
			honor_padding = true,
			margins = {
				left = dpi(20),
				bottom = dpi(15),
			},
		})
	end,
})
-- }}}

-- Playerctl Bar Icon {{{
local _is_playing = false
local playerctl_bar_icon = wibox.widget({
	widget = wibox.widget.textbox,
	text = " ",
	valign = "center",
	buttons = awful.button({}, mouse.LEFT, function()
		if _is_playing then
			playerctl_window.visible = not playerctl_window.visible
		end
	end),
	align = "center",
	font = "Arimo Nerd Font 12",
})
-- }}}

-- Playerctl Events {{{
awesome.connect_signal("bling::playerctl::status", function(is_playing)
	_is_playing = is_playing
	if is_playing then
		playerctl_bar_icon.text = ""
		playerctl_btn.markup = C.colorify(beautiful.fg_constrast, " ")
	else
		playerctl_btn.markup = C.colorify(beautiful.fg_constrast, "契")
		playerctl_bar_icon.text = " "
	end
end)

awesome.connect_signal("bling::playerctl::title_artist_album", function(title, _, art)
	playerctl_image:set_image(gears.surface.load_uncached(art))
	playerctl_title:set_text(C.trim_long(title))
end)
-- }}}

return {
	playerctl = playerctl_bar_icon,
}
