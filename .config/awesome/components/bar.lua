local cl = require('misc.libs.stdlib')--.color

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
	time.font = 'Ringbearer Medium 16'
	cl.tooltip(time,
	  function()
		return require('lgi').GLib.DateTime.new_now_local():format("%d-%B-%y (%a) - %I:%M %P")
	  end,
	  function(c)
		awful.placement.bottom(c, { honor_workarea = true, margins = { bottom = dpi(4) } })
	end)

	local layout_no = wibox.widget.textbox()
	layout_no.font = 'Ringbearer Medium 16'
	layout_no.text = 0 -- s.selected_tag.index

	-- [WARN] Might cause issues if you have > 3 workspaces
	awful.screen.focused():connect_signal("tag::history::update", function()
	  layout_no.text = string.rep("i", s.selected_tag.index)
	end)
	
	s.mywibar = awful.wibar({
		position = 'bottom',
		screen = s,
		ontop = true,
		type = 'dock',
	})
	s.mywibar:setup({
		{
			{
				border_width = 0,
				span_ratio = 1,
				thickness = beautiful.wibar_top_border_width,
				widget = wibox.widget.separator,
			},
			widget = wibox.container.constraint,
			height = beautiful.wibar_top_border_width,
		},
		{
			require('subcomponents.tasklist')(s),
			{
				time,
				layout = wibox.layout.fixed.horizontal,
			},
			{
			  {
			  wibox.widget.systray(),
			  layoutbox,
			  layout_no,
			  spacing = dpi(4),
			  layout = wibox.layout.fixed.horizontal,
			  },
			  widget = wibox.container.margin,
			  margins = dpi(4)
			},
			expand = 'none',
			layout = wibox.layout.align.horizontal,
		},
		layout = wibox.layout.fixed.vertical,
	})
end)
