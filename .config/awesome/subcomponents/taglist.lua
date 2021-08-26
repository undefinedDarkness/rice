--[[bling.widget.tag_preview.enable({
	show_client_content = false,
	scale = 0.3,
	placement_fn = function(c)
		awful.placement.bottom(c, { margins = { bottom = 80 } })
	end,
	honor_padding = true,
	honor_workarea = true,
})]]

-- Create a taglist widget
return function(s)
	return wibox.widget({
		--{
		awful.widget.taglist({
			screen = s,
			filter = awful.widget.taglist.filter.all,
			layout = {
				spacing = dpi(5),
				layout = wibox.layout.fixed.horizontal,
			},
			widget_template = {
				valign = "center",
				align = "center",
				text = "○",
				font = "Monospace 20",
				widget = wibox.widget.textbox,
				update_callback = function(self, tag)
					if tag == awful.screen.focused().selected_tag then
						self.text = "◉"
					else
						self.text = "○"
					end
				end,
				create_callback = function(self, c3, _, _)
					if c3 == awful.screen.focused().selected_tag then
						self.text = "◉"
					else
						self.text = "○"
					end

					self:connect_signal("mouse::enter", function()
						local clients = c3:clients()

						-- Filter table of minimized clients
						--[[local o = {}
							for k, v in pairs(clients) do
								if not v.minimized then
									o[k] = v
								end
							end

							if (#o > 0) and (c3 ~= awful.screen.focused().selected_tag) then
								awesome.emit_signal("bling::tag_preview::update", c3)
								awesome.emit_signal("bling::tag_preview::visibility", s, true)
							end]]
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
		--[[widget = wibox.container.margin,
			left = dpi(10),
			right = dpi(10),
		},]]
		widget = wibox.container.background,
		fg = "#373b41",
		bg = "#00000000",
		shape = function(cr, w, h)
			gears.shape.rounded_rect(cr, w, h, 5)
		end,
	})
end
