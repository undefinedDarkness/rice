local cl = require('platform.stdlib') --.color

awful.screen.connect_for_each_screen(function(s)
	local layoutbox = awful.widget.layoutbox.new({ screen = s })
	layoutbox._layoutbox_tooltip:remove_from_object(layoutbox)
	require('subcomponents.tooltip').new({
		placement = awful.placement.top_left,
		widget = require('subcomponents.tooltip').layoutlist,
		trigger = layoutbox,
		mh = 40,
		mw = 100,
		autoleave = true,
	})
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

	local layout_no = wibox.widget.textbox()
	layout_no.text = 0 -- s.selected_tag.index
	layout_no.font = 'IBM Plex Sans Medium'
	layout_no.valign = 'center'
	layout_no.align = 'center'
	layout_no:buttons(awful.button({}, mouse.LEFT, function()
		awful.tag.viewnext(mouse.screen)
	end))

	local clock = awful.widget.textclock("<b>%H\n<span foreground='#888'>―</span>\n%M</b>")
	clock.align = 'center'
	require('subcomponents.tooltip').new({
		placement = awful.placement.left,
		widget = awful.widget.textclock('<b>%A</b>\n%d/%m/%y'),
		trigger = clock,
		mh = 60,
		mw = 100,
		autoleave = true,
	})

	awful.screen.focused():connect_signal('tag::history::update', function()
		layout_no.markup = s.selected_tag.name
	end)

	local tray = wibox.widget.systray()
	tray:set_horizontal(false)

	s.mywibar = awful.wibar({
		position = 'left',
		screen = s,
		ontop = true,
		type = 'dock',
	})
	s.mywibar:setup({
		{
			layout = wibox.layout.fixed.vertical,
			spacing = dpi(8),
			layoutbox,
			layout_no,
			require('subcomponents.tasklist'),
		},
		clock,
		{ tray, widget = wibox.container.margin, margins = 8 },
		layout = wibox.layout.align.vertical,
		expand = 'none',
		buttons = awful.button({}, mouse.LEFT, require('components.dashboard')),
	})
end)
