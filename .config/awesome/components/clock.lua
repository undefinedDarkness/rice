awful.popup({
	placement = function(c) awful.placement.top_right(c, {
		margins = {
			top = 50,
			right = 50
		}
	}) end,
	widget = {
		widget = wibox.widget.textclock,
		format = "<span size=\"90000\" font=\"Paralines\">%H\n%M</span>"
	},
	type = 'dock',
	bg = '#00000000',
	fg = '#fafafa'
})
