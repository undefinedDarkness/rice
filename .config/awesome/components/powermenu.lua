local shadow_box = require('misc.libs.stdlib').shadow_box
local contain_image = require('misc.libs.stdlib').contain_image

local m = {widget=require('misc.libs.imagebox')}

local shutdown = shadow_box.new(
  contain_image(gears.filesystem.get_configuration_dir() .. "theme/assets/icons/shutdown.svg", 100, 100, m),
		8,
		8, '#fafafa')
shutdown:buttons(awful.button({}, 1, function() awful.spawn("systemctl poweroff") end))
shadow_box.toggle(shutdown)

local restart = shadow_box.new(
		contain_image(gears.filesystem.get_configuration_dir() .. "theme/assets/icons/reboot.svg", 100, 100, m),
		8,
		8, '#fafafa')
shadow_box.toggle(restart)
restart:buttons(awful.button({}, 1 , function()
  awful.spawn("systemctl reboot")
end))

local logout = shadow_box.new(
  contain_image(gears.filesystem.get_configuration_dir() .. "theme/assets/icons/exit.svg", 100, 100, m),
		8,
		8, '#fafafa')
shadow_box.toggle(logout)
logout:buttons(awful.button({}, 1, function()
  awesome.quit()
end))

shutdown:connect_signal("mouse::enter", shadow_box.toggle)
shutdown:connect_signal("mouse::leave", shadow_box.toggle)
logout:connect_signal("mouse::enter", shadow_box.toggle)
logout:connect_signal("mouse::leave", shadow_box.toggle)
restart:connect_signal("mouse::enter", shadow_box.toggle)
restart:connect_signal("mouse::leave", shadow_box.toggle)
local popup = awful.popup {
  screen = awful.screen.focused(),
  ontop = true,
  type = 'dock',
  widget = {
	widget = wibox.container.margin,
	-- margins = dpi(20),
	{
	  layout = wibox.layout.fixed.horizontal,
	  shutdown,
	  restart,
	  logout,
	  spacing = dpi(16)
	}
  },
  bg = '#00000000',
  placement = awful.placement.centered
}

return function()
  require('misc.libs.stdlib').only_popup(popup)
end
