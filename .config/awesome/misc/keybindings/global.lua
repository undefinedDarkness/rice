local hotkeys_popup = require("awful.hotkeys_popup")

local is_using_semimak = false
local tabbed = bling.module.tabbed

globalkeys = gears.table.join(
	-- Personal Section {{{

	awful.key({ modkey, "Shift" }, "KP_Add", function()
		require("components.sliders").volume()
	end),

	awful.key({ modkey }, "KP_Add", function()
		require("components.sliders").brightness()
	end),

	awful.key({ modkey, "Shift" }, "w", function()
		local x = ""
		if is_using_semimak then
			x = "Colemak"
			awful.spawn("setxkbmap us -variant colemak")
		else
			x = "Semimak"
			awful.spawn("setxkbmap semimak -variant angle")
		end
		require("naughty").notify({
			title = "Keyboard",
			text = "Changed layout to " .. x,
			-- TODO: Get a better icon
			icon = "/usr/share/icons/Papirus-Dark/16x16/devices/keyboard.svg",
		})
		is_using_semimak = not is_using_semimak
	end, {
		group = "User",
		description = "Switch between keyboard layouts",
	}),
	awful.key({ modkey, "Shift" }, "p", function()
		require("subcomponents.quick_menu").power()
	end, {
		group = "User",
		description = "Toggle powermenu",
	}),
	awful.key(
		{ modkey },
		"Print",
		require("misc.libs.screenshot").selection,
		{ description = "Take Screenshot (selection)", group = "User" }
	),
	awful.key({ modkey, "Shift" }, "Print", function()
		require("subcomponents.quick_menu").screenshot()
	end, {
		description = "Take Screenshot (menu)",
		group = "User",
	}),
	awful.key({ modkey }, "w", function()
		awful.spawn.with_shell("firefox -P default-release")
	end, {
		description = "Open Web Browser",
		group = "User",
	}),
	awful.key({ modkey, "Shift" }, "e", function()
		awful.spawn("bash " .. user_home .. "/Documents/Scripts/emoji")
	end, {
		group = "User",
		description = "Emoji Picker",
	}),
	awful.key({ modkey }, "d", function()
		require("subcomponents.menu").launcher:toggle()
	end, {
		description = "Launch Dmenu (Run)",
		group = "User",
	}),

	-- BLING TABS {{{
	awful.key({ modkey, "Shift" }, "t", function()
		bling.module.tabbed.pick()
	end, {
		description = "Add tab to tabbing group",
		group = "User",
	}),
	awful.key({ modkey, "Shift" }, "r", function()
		bling.module.tabbed.pop()
	end, {
		description = "Remove tab from tabbing group",
		group = "User",
	}),
	-- }}}

	-- }}}
	awful.key({ modkey }, "s", hotkeys_popup.show_help, {
		description = "show help",
		group = "awesome",
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
		group = "screen",
	}),
	awful.key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, {
		description = "focus the previous screen",
		group = "screen",
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
		awful.spawn(terminal)
	end, {
		description = "open a terminal",
		group = "launcher",
	}),
	awful.key({ modkey, "Control" }, "r", awesome.restart, {
		description = "reload awesome",
		group = "awesome",
	}),
	awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
	awful.key({ modkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, {
		description = "increase master width factor",
		group = "layout",
	}),
	awful.key({ modkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, {
		description = "decrease master width factor",
		group = "layout",
	}),
	awful.key({ modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, {
		description = "increase the number of master clients",
		group = "layout",
	}),
	awful.key({ modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, {
		description = "decrease the number of master clients",
		group = "layout",
	}),
	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, {
		description = "increase the number of columns",
		group = "layout",
	}),
	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, {
		description = "decrease the number of columns",
		group = "layout",
	}),
	awful.key({ modkey }, "space", function()
		awful.layout.inc(1)
	end, {
		description = "select next",
		group = "layout",
	}),
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
	}), -- Prompt
	awful.key({ modkey }, "r", function()
		awful.screen.focused().mypromptbox:run()
	end, {
		description = "run prompt",
		group = "launcher",
	}),
	awful.key({ modkey }, "x", function()
		awful.prompt.run({
			prompt = "🌙: ",
			textbox = awful.screen.focused().mypromptbox.widget,
			fg = "#d4be98",
			font = "Sarasa UI HC Italic 10",
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, {
		description = "lua execute prompt",
		group = "awesome",
	})
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
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, {
			description = "toggle tag #" .. i,
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
		}),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, {
			description = "toggle focused client on tag #" .. i,
			group = "tag",
		})
	)
end

root.keys(globalkeys)
