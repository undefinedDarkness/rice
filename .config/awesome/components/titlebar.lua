client.connect_signal('request::titlebars', function(c)
	-- Titlebar Buttons
	local raise = function()
		c:emit_signal('request::activate', 'titlebar', { raise = true })
	end
	local titlebar_buttons = gears.table.join(
		awful.button({}, mouse.LEFT, function()
			raise()
			awful.mouse.client.move(c)
		end),
		awful.button({}, mouse.RIGHT, function()
			raise()
			awful.mouse.client.resize(c)
		end),
		awful.button({ 'Shift' }, mouse.LEFT, function()
			raise()
			c.maximized = not c.maximized
		end),
		awful.button({ 'Shift' }, mouse.RIGHT, function()
			raise()
			require('subcomponents.layout')(c)
		end)
	)

	local title = wibox.widget.textbox(c.name:lower())
	title.font = beautiful.titlebar_font
	local update_name = function()
		if c.class == 'Thunar' then
			title.text = 'fm: ' .. c.name
		else
			title.text = c.name:lower()
		end
	end
	c:connect_signal('property::name', update_name)
	update_name()

	-- Titlebar Setup!
	awful.titlebar(c, {
		size = dpi(48),
		position = 'left',
	}):setup({
		{
			{
				{{
					widget = wibox.container.background,
					bg = require('misc.libs.stdlib').color.darken('#ab9382'),
					shape = function(cr, w, h)
						gears.shape.transform(gears.shape.cross):rotate_at(w / 2, h / 2, math.pi / 4)(
							cr,
							w,
							h,
							4
						)
					end,
				}, widget = wibox.container.margin, margins = dpi(8) },
				widget = wibox.container.background,
				forced_height = dpi(48),
				forced_width = dpi(48),
				bg = '#ab9382',
			},
			require('misc.libs.stdlib').force_right(bling.widget.tabbed_misc.titlebar_indicator(c, {
				layout = wibox.layout.fixed.vertical,
				bg_color_focus = beautiful.titlebar_fg_focus,
				bg_color = '#00000000',
				widget_template = {
					{
						{
							{
								widget = wibox.container.background,
								id = 'bg_role',
								forced_width = dpi(8),
								forced_height = dpi(8),
								shape = function(cr, w, h)
									gears.shape.rounded_rect(cr, w, h, 3)
								end,
							},
							widget = wibox.container.margin,
							margins = dpi(3),
						},
						widget = wibox.container.margin,
						margins = dpi(2),
						color = beautiful.titlebar_fg_focus,
					},
					widget = wibox.container.constraint,
					width = 32,
					height = 32,
					shape = function(cr, w, h)
						gears.shape.rounded_rect(cr, w, h, 3)
					end,
				},
			})),
			layout = wibox.layout.align.vertical,
		},
		buttons = titlebar_buttons,
		widget = wibox.container.margin,
		-- right = dpi(5),
		-- left = dpi(5),
	})

	awful.titlebar.hide(c, 'left')
	c:connect_signal('mouse::enter', function()
		awful.titlebar.show(c, 'left')
	end)

	c:connect_signal('mouse::leave', function()
		if not (client.focus == c) then
			awful.titlebar.hide(c, 'left')
		end
	end)

	c:connect_signal('unfocus', function()
		awful.titlebar.hide(c, 'left')
	end)
end)

client.connect_signal('focus', function()
	awful.titlebar.show(client.focus, 'left')
end)
