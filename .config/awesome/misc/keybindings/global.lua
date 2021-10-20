local hotkeys_popup = require("awful.hotkeys_popup")

local tabbed = bling.module.tabbed

globalkeys = gears.table.join(

	awful.key({ modkey }, "Print", function()
		awful.spawn.with_shell(beautiful.on_screenshot)
	end, {
		description = "Take Screenshot (selection)",
		group = "User",
	}),
	awful.key({ modkey }, "d", function()
		require("components.ss")
	end, {
		description = "Launch Dmenu (Run)",
		group = "User",
	}),

	awful.key({ modkey }, "o", function()
		require("components.overview")(true)
	end, {
		description = "Launch tag overview",
		group = "User",
	}),

	awful.key({ modkey, "Shift" }, "t", function()
		bling.module.tabbed.pick()
	end, {
		description = "Add tab to tabbing group",
		group = "Bling",
	}),
	awful.key({ modkey, "Shift" }, "r", function()
		bling.module.tabbed.pop()
	end, {
		description = "Remove tab from tabbing group",
		group = "Bling",
	}),

	awful.key({ modkey }, "s", function()
		require("subcomponents.keys")()
	end, {
		description = "show help",
		group = "User",
	}),
	awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey }, "Right", awful.tag.viewnext, {
		description = "view next",
		group = "tag",
	}),
	awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

	awful.key({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, {
		description = "focus next by index",
		group = "client",
	}),
	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, {
		description = "swap with next client by index",
		group = "client",
	}),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, {
		description = "swap with previous client by index",
		group = "client",
	}),
	awful.key({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, {
		description = "focus the next screen",
		group = "awesome",
	}),
	awful.key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, {
		description = "focus the previous screen",
		group = "awesome",
	}),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, {
		description = "jump to urgent client",
		group = "client",
	}),
	awful.key({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, {
		description = "go back",
		group = "client",
	}), -- Standard program
	awful.key({ modkey }, "t", function()
		awful.spawn(beautiful.terminal)
	end, {
		description = "open a terminal",
		group = "User",
	}),
	awful.key({ modkey, "Control" }, "r", awesome.restart, {
		description = "reload awesome",
		group = "awesome",
	}),
	awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, {
		description = "select previous",
		group = "layout",
	}),
	awful.key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, {
		description = "restore minimized",
		group = "client",
	}) -- Prompt
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = gears.table.join(
		globalkeys, -- View tag only.
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, {
			description = "view tag #" .. i,
			group = "tag",
		}),

		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, {
			description = "move focused client to tag #" .. i,
			group = "tag",
		})
	)
end

root.keys(globalkeys)
