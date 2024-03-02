local shadow_box = require('platform.stdlib').shadow_box
local contain_image = require('platform.stdlib').contain_image

local m = { widget = wibox.widget.imagebox }

local shutdown_fn = function()
	awful.spawn('systemctl poweroff')
end
local logout_fn = function()
	awesome.quit()
end
local restart_fn = function()
	awful.spawn('systemctl reboot')
end

local shutdown = shadow_box.new(
	contain_image(gears.filesystem.get_configuration_dir() .. 'theme/assets/icons/shutdown.svg', 100, 100, m),
	8,
	8,
	'#fafafa'
)
shutdown:buttons(awful.button({}, 1, shutdown_fn))
shadow_box.toggle(shutdown)

local restart = shadow_box.new(
	contain_image(gears.filesystem.get_configuration_dir() .. 'theme/assets/icons/reboot.svg', 100, 100, m),
	8,
	8,
	'#fafafa'
)
shadow_box.toggle(restart)
restart:buttons(awful.button({}, 1, restart_fn))

local logout = shadow_box.new(
	contain_image(gears.filesystem.get_configuration_dir() .. 'theme/assets/icons/exit.svg', 100, 100, m),
	8,
	8,
	'#fafafa'
)
shadow_box.toggle(logout)
logout:buttons(awful.button({}, 1, logout_fn))

local function trigger()
	if shadow_box.is_active(shutdown) then
		shutdown_fn()
	elseif shadow_box.is_active(logout) then
		logout_fn()
	else
		restart_fn()
	end
end

local function toggle_on(w)
	shadow_box.off(shutdown)
	shadow_box.off(logout)
	shadow_box.off(restart)
	shadow_box.on(w)
end

local function cycle()
	if shadow_box.is_active(shutdown) then
		toggle_on(restart)
	elseif shadow_box.is_active(logout) then
		toggle_on(shutdown)
	else
		toggle_on(logout)
	end
end

shutdown:connect_signal('mouse::enter', toggle_on)
shutdown:connect_signal('mouse::leave', shadow_box.off)
logout:connect_signal('mouse::enter', toggle_on)
logout:connect_signal('mouse::leave', shadow_box.off)
restart:connect_signal('mouse::enter', toggle_on)
restart:connect_signal('mouse::leave', shadow_box.off)
toggle_on(shutdown)

local popup = awful.popup({
	screen = awful.screen.focused(),
	ontop = true,
	type = 'dock',
	widget = {
		widget = wibox.container.margin,
		{
			layout = wibox.layout.fixed.horizontal,
			shutdown,
			restart,
			logout,
			spacing = dpi(16),
		},
	},
	bg = '#00000000',
	placement = awful.placement.centered,
})

return function()
	require('platform.stdlib').only_popup(popup, true, false, {
		{ {}, 'Tab', cycle },
		{ {}, 'Return', trigger },
	})
end
