local   taglist_buttons = {
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                                            if client.focus then
                                                client.focus:move_to_tag(t)
                                            end
                                        end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                                            if client.focus then
                                                client.focus:toggle_tag(t)
                                            end
                                        end),
            awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
        } 

awful.screen.connect_for_each_screen(function(screen)
	awful.popup {
		widget = awful.widget.taglist {
			screen = screen,
			filter =  awful.widget.taglist.filter.all,
			style = {
				bg_focus = "#e7a380",
				bg_empty = "transparent",
				bg_occupied = beautiful.wibar_fg,
				shape = gears.shape.circle,
				spacing = 8,
				shape_border_color = "transparent",
				shape_border_width = 2,
				-- shape_border_color_focus = "#e7a380",
				shape_border_color_empty = beautiful.wibar_fg
			},
			widget_template = {
				widget = wibox.container.background,
				id = 'background_role',
				forced_width = 16,
				forced_height = 16
			},
			buttons = taglist_buttons
		},
		bg = beautiful.wibar_bg,
		placement = function(d) awful.placement.top(d, { margins = { top = 8 } }) end,
		ontop = false,
		type = 'splash',
		screen = screen,

	}
end)
