local cl = require('misc.libs.stdlib') --.color

awful.screen.connect_for_each_screen(function(s)
	local layoutbox = awful.widget.layoutbox.new(s.index)
	layoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))

	local time = wibox.widget.textclock(beautiful.clock_fmt)
	awful.tooltip({
		objects = { time },
		timer_function = function()
			return require('lgi').GLib.DateTime.new_now_local():format('%d-%B-%y (%a) - %I:%M %P')
		end,
		timeout = 60,
	})
	local layout_no = wibox.widget.textbox()
	layout_no.text = 0 -- s.selected_tag.index
	layout_no.font = 'IBM Plex Sans Medium'
	layout_no.valign = 'center'
	layout_no:buttons(awful.button({}, mouse.LEFT, function()
		awful.tag.viewnext(mouse.screen)
	end))

	awful.screen.focused():connect_signal('tag::history::update', function()
		layout_no.markup = s.selected_tag.name
	end)

	s.mywibar = awful.wibar({
		position = 'bottom',
		screen = s,
		ontop = true,
		type = 'dock',
	})
	s.mywibar:setup({
		-- {
		-- 	{
		-- 		border_width = 0,
		-- 		span_ratio = 1,
		-- 		thickness = beautiful.wibar_top_border_width,
		-- 		widget = wibox.widget.separator,
		-- 	},
		-- 	widget = wibox.container.constraint,
		-- 	height = beautiful.wibar_top_border_width,
		-- },
		{
			{
				{
					layoutbox,
					require('subcomponents.tasklist')(s),
					layout = wibox.layout.fixed.horizontal,
					spacing = dpi(8),
					spacing_widget = wibox.widget.separator,
				},
				nil,
				{
					time,
					{ wibox.widget.systray(), widget = wibox.container.margin, margins = 4 },
					{
						widget = wibox.widget.separator,
						orientation = 'vertical',
						forced_width = 5,
						color = '#888',
						thickness = 2,
					},
					layout_no,
					spacing = dpi(4),
					layout = wibox.layout.fixed.horizontal,
				},
				expand = 'none',
				layout = wibox.layout.align.horizontal,
			},
			widget = wibox.container.margin,
			right = 5,
		},
		layout = wibox.layout.fixed.vertical,
	})
end)
