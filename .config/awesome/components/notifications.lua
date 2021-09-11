-- Heavily inspired by javacafe's dotfiles (https://github.com/JavaCafe01/dotfiles/blob/master/.config/awesome/ui/notifs/init.lua)
local naughty = require("naughty")
local C = require("misc.libs.stdlib")

naughty.connect_signal("request::display", function(n)
	require("awful").screen.focused().activetext.markup = "<b>" .. (n.title or n.app_name) .. "</b>: " .. n.message

	gears.timer({
		timeout = 30,
		autostart = true,
		callback = function()
			require("awful").screen.focused().activetext.markup = ""
		end,
	})
end)
