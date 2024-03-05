local std = require('platform.stdlib')

return function()
	require('components.splashmsg')({
		layout = wibox.layout.fixed.horizontal,
		std.txt_button('󰐥 ', function()
			awful.spawn('systemctl poweroff')
		end, 'Poweroff'),
		std.txt_button('󰜉 ', function()
			awful.spawn('systemctl restart')
		end, 'Restart'),
		std.txt_button('󰍃 ', function()
			awesome.quit()
		end, 'Logout'),
	})
end
