local s = require("misc.screenshot")

local function get_icon(name)
	local gtk = require("lgi").Gtk
	return gtk.IconTheme.get_default():lookup_icon(name, 64, {}):get_filename()
end

function quick_menu(x)
	local items = wibox.layout.fixed.vertical()
	items.spacing = dpi(8)
	for _, v in ipairs(x) do
		items:add({
			widget = wibox.widget.imagebox,
			image = v.image,
			forced_height = dpi(24),
			buttons = awful.button({}, mouse.LEFT, v.exe),
			forced_width = dpi(24),
			resize = true,
		})
	end

	local menu = awful.popup({
		visible = false,
		hide_on_right_click = true,
		widget = wibox.widget({
			items,
			widget = wibox.container.margin,
			left = dpi(8),
			right = dpi(8),
			top = dpi(12),
			bottom = dpi(12),
		}),
		border_width = dpi(1),
		border_color = beautiful.bg_lighter,
		ontop = true,
		shape = gears.shape.rounded_bar,
		placement = function(x)
			awful.placement.bottom_left(x, { honor_workarea = true, margins = { bottom = 25, left = 25 } })
		end,
	})

	return function()
		menu.visible = not menu.visible
	end
end

return {
	create = quick_menu,
	power = function()
		quick_menu({
			{
				image = get_icon("system-shutdown"),
				exe = function()
					awful.spawn("systemctl poweroff")
				end,
			},
			{
				image = get_icon("system-restart"),
				exe = function()
					awful.spawn("systemctl reboot")
				end,
			},
			{
				image = get_icon("system-log-out"),
				exe = function()
					awesome.quit()
				end,
			},
		})()
	end,
	screenshot = function()
		quick_menu({
			{ image = get_icon("image-crop"), exe = s.selection },
			{ image = get_icon("video-display"), exe = s.root },
			{ image = get_icon("appointment"), exe = s.win },
		})()
	end,
}
