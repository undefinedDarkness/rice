local draw_task = bling.widget.task_preview.draw_widget

-- {{{
local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal('request::activate', 'tasklist', { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)
-- }}}

-- {{{
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

-- }}}

local tasklist = awful.widget.tasklist({
	screen = awful.screen.focused(),
	buttons = tasklist_buttons,
	filter = awful.widget.tasklist.filter.currenttags,
	layout = { layout = wibox.layout.flex.horizontal },
	widget_template = {
		{
			widget = wibox.container.margin,
			margins = 40,
			{
				id = 'icon_role',
				widget = wibox.widget.imagebox,
			},
		},
		widget = wibox.container.background,
		id = 'background_role',
	},
	style = {
		shape_border_width = 2,
		shape_border_color = 'cream',
		bg_normal = '#00000000',
		bg_focus = '#eaeaea',
		shape = function(cr, w, h)
			gears.shape.rounded_rect(cr, w, h, 20)
		end,
	},
})

local clock = wibox.widget.textclock('%H:%M')
clock.font = 'IBM Plex Sans Medium 12'
local systray = wibox.widget.systray()
systray:set_base_size(24)
local layout = wibox.widget({ awful.widget.layoutbox(), widget = wibox.container.constraint, height = 24, width = 24 })
layout:buttons(gears.table.join(
	awful.button({}, 1, function()
		awful.layout.inc(1)
	end),
	awful.button({}, 3, function()
		awful.layout.inc(-1)
	end)
))

local taglist = awful.widget.taglist({
	screen = awful.screen.focused(),
	buttons = taglist_buttons,
	filter = awful.widget.taglist.filter.all,
	layout = {
		layout = wibox.layout.fixed.horizontal,
	},
	style = {
		bg_focus = '#fafafa',
		bg_occupied = '#ddd',
		bg_empty = '#ddd',
		shape_focus = function(cr, w, h)
			gears.shape.partially_rounded_rect(cr, w, h, true, true, false, false)
		end,
	},
	widget_template = {
		{
			{
				widget = wibox.widget.textbox,
				id = 'text_role',
				font = 'IBM Plex Sans Medium 13',
			},
			widget = wibox.container.margin,
			top = 5,
			bottom = 5,
			left = 24,
			right = 24,
		},
		widget = wibox.container.background,
		id = 'background_role',
	},
})

local main_layout = {
	layout = wibox.layout.fixed.vertical,

	-- TAGLIST
	{
		taglist,
		widget = wibox.container.background,
		bg = '#ddd',
	},

	-- TASKLIST
	{
		{
			{
				{
					{
						tasklist,
						widget = wibox.container.place,
						halign = 'left',
						-- valign = 'center'
					},
					widget = wibox.container.margin,
					left = 15,
					right = 15,
					top = 15,
				},
				widget = wibox.container.constraint,
				height = 160,
			},

			{
				{
					layout,
					clock,
					systray,
					expand = 'none',
					layout = wibox.layout.align.horizontal,
				},
				widget = wibox.container.margin,
				left = 16,
				right = 16,
			},
			layout = wibox.layout.fixed.vertical,
			spacing = dpi(15),
			spacing_widget = wibox.widget.separator,
		},
		widget = wibox.container.background,
		bg = '#fafafa',
	},
}

local window = awful.popup({
	widget = main_layout,
	visible = false,
	maximum_height = 250,
	bg = '#00000000',
	fg = '#111111',
	shape = function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, 8)
	end,
	ontop = true,
	placement = awful.placement.centered,
})

return function()
	window.visible = not window.visible

	if window.visible then
		awful.keygrabber({
			autostart = true,
			keybindings = {
				{
					{},
					'Tab',
					function()
						awful.client.focus.byidx(1)
					end,
				},
			},
			stop_key = 'Escape',
			stop_callback = function()
				window.visible = false
				awful.client.focus.history.enable_tracking()
			end,
		})
	end
end
