local custom = require("misc.libs.stdlib")

clientkeys = gears.table.join(
	-- Fullscreen Window
	awful.key({ modkey }, "f", function(c)
		awful.screen.focused().mywibar.ontop = c.fullscreen
		c.fullscreen = not c.fullscreen
		c:raise()
	end, {
		description = "toggle fullscreen",
		group = "client",
	}),
	awful.key({ modkey, "Shift" }, "Up", function(c)
		awful.client.swap.bydirection("up", c)
	end, {
		description = "Move client up",
		group = "client",
	}),
	awful.key({ modkey, "Shift" }, "Left", function(c)
		awful.client.swap.bydirection("left", c)
	end, {
		description = "Move client left",
		group = "client",
	}),
	awful.key({ modkey, "Shift" }, "Right", function(c)
		awful.client.swap.bydirection("right", c)
	end, {
		description = "Move client right",
		group = "client",
	}),
	awful.key({ modkey, "Shift" }, "Down", function(c)
		awful.client.swap.bydirection("down", c)
	end, {
		description = "Move client in down",
		group = "client",
	}),
	-- }}}
	-- Close Window
	awful.key({ modkey, "Shift" }, "c", function(c)
		c:kill()
	end, { description = "close", group = "client" }),

	awful.key({ modkey }, "n", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, {
		description = "minimize",
		group = "client",
	}),
	awful.key({ modkey }, "m", function(c)
		-- awful.titlebar.toggle(c)
		c.maximized = not c.maximized
		c:raise()
	end, {
		description = "(un)maximize",
		group = "client",
	}),

	-- Toggle titlebar
	awful.key({ modkey }, "k", function(c)
		awful.titlebar.toggle(c)
	end, {
		description = "Toggle titlebar",
		group = "client",
	})
)

return clientkeys
