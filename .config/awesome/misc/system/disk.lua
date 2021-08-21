-- Use /dev/sdxY according to your setup
local disk_script = [[
    sh -c "
    df -kh -B 1MB $(df . | grep -Eo '/dev/\w+') | tail -1 | awk '{printf \"%d@%d\", $4, $3}'
    "
]]

-- Periodically get disk space info
return gears.timer({
	timeout = update_interval,
	call_now = true,
	callback = function()
		awful.spawn.easy_async(disk_script, function(stdout)
			local available = tonumber(stdout:match("^(.*)@")) / 1000
			local used = tonumber(stdout:match("@(.*)$")) / 1000
			awesome.emit_signal("system::disk", used, available + used)
		end)
	end,
})
