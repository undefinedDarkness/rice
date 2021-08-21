bling.widget.tag_preview.enable({
	show_client_content = false,
	scale = 0.25,
	placement_fn = function(c)
		awful.placement.top_left(c, { margins = { top = 30, left = 50 } })
	end,
	honor_padding = true,
	honor_workarea = true,
})

-- Create a taglist widget
return function(s)
	return wibox.widget({
		awful.widget.taglist({
			screen = s,
			filter = awful.widget.taglist.filter.all,
			layout = wibox.layout.fixed.vertical,
			style = {
				fg_focus = beautiful.bg_urgent,
				fg_occupied = beautiful.fg_normal,
				fg_empty = beautiful.fg_normal,
				font = "Arimo Nerd Font 12",
			},
			widget_template = {
				{
					{
						id = "text_role",
						widget = wibox.widget.textbox,
						align = "center",
						valign = "center",
					},
					widget = wibox.container.margin,
					top = dpi(6),
					bottom = dpi(6),
					--margins = dpi(6),
				},
				layout = wibox.layout.fixed.vertical,
				create_callback = function(self, c3, _, _)
					self:connect_signal("mouse::enter", function()
						local clients = c3:clients()

						-- Filter table of minimized clients
						local o = {}
						for k, v in pairs(clients) do
							if not v.minimized then
								o[k] = v
							end
						end

						if #o > 0 then
							awesome.emit_signal("bling::tag_preview::update", c3)
							awesome.emit_signal("bling::tag_preview::visibility", s, true)
						end
					end)

					self:connect_signal("mouse::leave", function()
						awesome.emit_signal("bling::tag_preview::visibility", s, false)
					end)
				end,
			},
			buttons = {
				awful.button({}, mouse.LEFT, function(t)
					t:view_only()
				end),
				awful.button({ modkey }, mouse.LEFT, function(t)
					if client.focus then
						client.focus:move_to_tag(t)
					end
				end),
				awful.button({}, mouse.RIGHT, awful.tag.viewtoggle),
				awful.button({ modkey }, mouse.RIGHT, function(t)
					if client.focus then
						client.focus:toggle_tag(t)
					end
				end),
				awful.button({}, mouse.SCROLL_UP, function(t)
					awful.tag.viewprev(t.screen)
				end),
				awful.button({}, mouse.SCROLL_DOWN, function(t)
					awful.tag.viewnext(t.screen)
				end),
			},
		}),
		widget = wibox.container.background,
		bg = beautiful.bg_normal2,
		shape = function(cr, w, h)
			gears.shape.partially_rounded_rect(cr, w, h, false, false, true, true, 100)
		end,
	})
end
