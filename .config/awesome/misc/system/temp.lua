return gears.timer({
	timeout = update_interval,
	call_now = true,
	callback = function()
		awful.spawn.easy_async([[cat /sys/class/thermal/thermal_zone1/temp]], function(out)
			awesome.emit_signal("system::temp", tonumber(out) / 1000)
		end)
	end,
})
