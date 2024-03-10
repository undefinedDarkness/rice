require('components.dashboard').register_update(function(display)
	if display then
		awful.spawn.with_shell('python3 ~/rice/scripts/notion-dashboard.py || pkill -f --signal SIGUSR1 notion-dashboard.py', { special = true })
	else
		awful.spawn.with_shell('pkill -f --signal SIGUSR1 notion-dashboard.py', { special = true })
	end
end)
