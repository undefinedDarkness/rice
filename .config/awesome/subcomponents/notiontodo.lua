require('components.dashboard').register_update(function(display)
	if display then
		awful.spawn.with_shell(
			'~/rice/scripts/.venv/bin/python3 ~/rice/scripts/notion-dashboard.py || pkill -f --signal SIGUSR1 notion-dashboard.py',
			{ special = true }
		)

		-- awful.spawn.with_shell('~/rice/misc/mkr/build/mkr', { special = true })
	else
		awful.spawn.with_shell('pkill -f --signal SIGUSR1 notion-dashboard.py')
		-- awful.spawn.with_shell('pkill -f --signal SIGUSR1 mkr')
	end
end)
