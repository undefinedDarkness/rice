return gears.timer({
	timeout = update_interval,
	call_now = true,
	callback = function()
		awful.spawn.easy_async("cat /sys/class/power_supply/BAT0/capacity", function(out)
			awesome.emit_signal("system::battery", tonumber(out))
		end)
	end,
})
