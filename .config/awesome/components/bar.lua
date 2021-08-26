function set_wallpaper(s, wallpaper)
	if wallpaper then
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

screen.connect_signal("request::wallpaper", function(s)
	set_wallpaper(s, beautiful.wallpaper)
end)

screen.connect_signal("request::desktop_decoration", function(s)
	awful.tag(workspaces, s, awful.layout.layouts[1])

	s.mylayoutbox = awful.widget.layoutbox({
		screen = s,
		buttons = {
			awful.button({}, mouse.LEFT, function()
				awful.layout.inc(1)
			end),
			awful.button({}, mouse.RIGHT, function()
				awful.layout.inc(-1)
			end),
			awful.button({}, mouse.SCROLL_UP, function()
				awful.layout.inc(-1)
			end),
			awful.button({}, mouse.SCROLL_DOWN, function()
				awful.layout.inc(1)
			end),
		},
	})

	s.activetext = wibox.widget({
		widget = wibox.widget.textbox,
		font = "JetBrains Mono 11"
	})
	s.activetext:connect_signal("property::text", function()
		if string.len(s.activetext.text) > 0 then
			s.activetext.markup = " " .. s.activetext.text -- This is such a big brain solution!
		end
	end)

	local tray = wibox.widget.systray()
	tray:set_horizontal(false)
	tray:set_base_size(28)

	local layout_box = awful.widget.layoutbox.new(s)
	layout_box.forced_width = dpi(20)
	layout_box.forced_height = dpi(20)
	layout_box.align = "center"
	layout_box.valign = "center"

	local clock = {
		widget = wibox.widget.textbox,
		align = "center",
		font = "JetBrains Mono 12",
	}
	gears.timer({
		autostart = true,
		call_now = true,
		timeout = 60,
		callback = function()
			local t = os.date("*t")
			clock.markup = "<b>"
				.. (t.hour < 10 and "0" .. t.hour or t.hour)
				.. "</b>:"
				.. (t.min < 10 and "0" .. t.min or t.min)
		end,
	})

	-- Create the wibox
	s.mywibar = awful.popup({
		placement = function(c)
			(awful.placement.bottom + awful.placement.maximize_horizontally)(
				c,
				{ margins = { bottom = 20, left = 20, right = 20 } }
			)
		end,
		visible = true,
		ontop = true,
		type = "dock",
		bg = beautiful.transparent,
		widget = {
			{
				{
					{
						{
							require("subcomponents.tasklist")(s),
							s.activetext, 
							layout = wibox.layout.fixed.horizontal,
						},
						widget = wibox.container.margin,
						margins = dpi(8),
						draw_empty = false
					},
					widget = wibox.container.background,
					bg = "#1d1f21",
					shape = function(cr, w, h)
						gears.shape.rounded_rect(cr, w, h, 5)
					end,
				},
				widget = wibox.container.place,
				halign = "bottom",
			},
			require("subcomponents.taglist")(s),
			{
				{
					{
						{
							layout_box,
							{
								wibox.widget.separator({
									orientation = "vertical",
									forced_width = 1,
									forced_height = 20,
								}),
								widget = wibox.container.margin,
								left = 5,
								right = 5,
							},
							clock,
							layout = wibox.layout.fixed.horizontal,
						},
						widget = wibox.container.margin,
						margins = dpi(8),
					},
					widget = wibox.container.background,
					bg = "#1d1f21",
					shape = function(cr, w, h)
						gears.shape.rounded_rect(cr, w, h, 5)
					end,
				},
				widget = wibox.container.place,
				halign = "bottom",
			},
			expand = "none",
			layout = wibox.layout.align.horizontal,
		},
	})
end)
