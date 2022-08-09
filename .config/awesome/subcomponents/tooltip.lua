local rubato = require('platform.libs.rubato')

local function new(args)
	local entered = false

	local p = wibox({
		visible = false,
		widget = {
			{ args.widget, widget = wibox.container.margin, margins = 8 },
			bg = '#f2f2f2',
			fg = 'black',
			-- border_width = 1,
			border_color = '#b2b2b2',
			widget = wibox.container.background,
		},
		width = 1,
		height = args.mh or 250,
		ontop = true,
		bg = '#00000000',
		shape = function(cr, w, h)
			gears.shape.partially_rounded_rect(cr, w, h, false, true, true, false, 5)
		end,
	})
	p:connect_signal('mouse::enter', function()
		entered = true
	end)
	p:connect_signal('mouse::leave', function()
		entered = false
	end)

	local ani = rubato.timed({
		duration = 1.0,
		pos = 1,
		subscribed = function(pos, time)
			p.width = pos
			if pos == 1 then
				p.visible = false
			end
		end,
	})

	if args.autoleave == true then
		args.trigger:connect_signal('mouse::leave', function()
			ani.target = 1
		end)
	end

	args.trigger:connect_signal('mouse::enter', function()
		p.visible = true
		p.width = 1
		args.placement(p, { honor_workarea = true, honor_padding = true, offset = { x = mouse.screen.mywibar.x  } })
		ani.target = args.mw or 250
	end)

	return p
end

local ll = awful.widget.layoutlist({
	base_layout = wibox.widget({
		spacing = 5,
		layout = wibox.layout.fixed.horizontal,
	}),
	widget_template = {
		{
			id = 'icon_role',
			widget = wibox.widget.imagebox,
		},
		widget = wibox.container.constraint,
		width = 24,
		height = 24,
	},
})

return {
	new = new,
	layoutlist = ll,
}
