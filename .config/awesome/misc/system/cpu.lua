local cpu_idle_script = [[
  sh -c "
  vmstat 1 2 | tail -1 | awk '{printf \"%d\", $15}'
  "]]

-- Periodically get cpu info
return gears.timer({
	timeout = update_interval,
	call_now = true,
	callback = function()
		awful.spawn.easy_async(cpu_idle_script, function(out)
			local cpu_idle = out
			cpu_idle = string.gsub(cpu_idle, "^%s*(.-)%s*$", "%1")
			awesome.emit_signal("system::cpu", 100 - tonumber(cpu_idle))
		end)
	end,
})
