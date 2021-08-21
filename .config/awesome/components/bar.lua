function set_wallpaper(s, wallpaper)
	-- Wallpaper
	if wallpaper then
		-- If wallpaper is a function, call it with the screen
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

	s.mypromptbox = awful.widget.prompt({
		prompt = "🚀: ",
		fg = beautiful.fg_normal,
		font = beautiful.font,
	})

	local tray = wibox.widget.systray()
	tray:set_horizontal(false)
	tray:set_base_size(28)

	local layout_box = awful.widget.layoutbox.new(s)
	layout_box.forced_width = dpi(16)
	layout_box.forced_height = dpi(16)
	layout_box.align = "center"
	layout_box.valign = "center"

	local clock = {
		widget = wibox.widget.textbox,
		align = "center",
		font = "JetBrains Mono 11",
	}
	gears.timer({
		autostart = true,
		call_now = true,
		timeout = 60,
		callback = function()
			local t = os.date("*t")
			clock.markup = "<b>"
				.. (t.hour < 10 and "0" .. t.hour or t.hour)
				.. "</b>\n"
				.. (t.min < 10 and "0" .. t.min or t.min)
		end,
	})

	-- Create the wibox
	s.mywibar = awful.wibar({
		position = "left",
		screen = s,
		width = dpi(40),
		ontop = true,
		bg = beautiful.bg_normal2,
	})

	-- Wibar Layout {{{
	s.mywibar.widget = {
		{
			{
				{
					widget = wibox.container.background,
					bg = beautiful.bg_normal,
				},
				require("subcomponents.taglist")(s),
				require("subcomponents.tasklist")(s),
				s.mypromptbox,
				layout = wibox.layout.fixed.vertical,
			},
			bg = beautiful.bg_highlight,
			widget = wibox.container.background,
			shape = function(cr, w, h)
				gears.shape.partially_rounded_rect(cr, w, h, false, false, true, true, 100)
			end,
		},
		nil,
		{
			{
				{
					--require("subcomponents.bar").playerctl,
					shape = function(cr, w, h)
						gears.shape.rounded_rect(cr, w, h, 100)
					end,
					widget = wibox.container.background,
					bg = beautiful.bg_normal2,
				},
				widget = wibox.container.margin,
				margins = dpi(5),
			},
			{
				{
					{
						{
							clock,
							widget = wibox.container.margin,
							top = 3,
							bottom = 3,
						},
						widget = wibox.container.background,
						shape = function(cr, w, h)
							gears.shape.rounded_rect(cr, w, h, 5)
						end,
						bg = "#3c3836",
					},
					tray,
					layout = wibox.layout.fixed.vertical,
				},
				widget = wibox.container.margin,
				margins = dpi(6),
			},
			layout = wibox.layout.fixed.vertical,
		},
		layout = wibox.layout.align.vertical,
		expand = "none",
	}
end)
