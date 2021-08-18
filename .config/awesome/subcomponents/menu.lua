local get_icon = require("menubar.utils").lookup_icon
local items = {
	{
		"Terminal",
		function()
			awful.spawn(terminal)
		end,
		get_icon(string.lower(terminal)),
	},
	{
		"Surf",
		function() end,
		get_icon("firefox"),
	},
}

return awful.menu(items)
