local custom = require("misc.custom")

clientkeys =
    gears.table.join(
    -- Fullscreen Window
    awful.key(
        {modkey},
        "f",
        function(c)
            awful.screen.focused().mywibar.ontop = c.fullscreen
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}
    ),
    -- Move By Direction {{{
    awful.key(
        {modkey, "Shift"},
        "Up",
        function(c)
            awful.client.swap.bydirection("up", c)
        end,
        {description = "Move client in direction", group = "client"}
    ),
    awful.key(
        {modkey, "Shift"},
        "Left",
        function(c)
            awful.client.swap.bydirection("left", c)
        end,
        {description = "Move client in direction", group = "client"}
    ),
    awful.key(
        {modkey, "Shift"},
        "Right",
        function(c)
            awful.client.swap.bydirection("right", c)
        end,
        {description = "Move client in direction", group = "client"}
    ),
    awful.key(
        {modkey, "Shift"},
        "Down",
        function(c)
            awful.client.swap.bydirection("down", c)
        end,
        {description = "Move client in direction", group = "client"}
    ),
    -- }}}
    -- Close Window
    awful.key(
        {modkey, "Shift"},
        "c",
        function(c)
            c:kill()
        end,
        {description = "close", group = "client"}
    ),
    -- Float / Unfloat
    --[[  awful.key({ modkey, "Control" }, "space",
        awful.client.floating.toggle,
        {description = "toggle floating", group = "client"}), --]]
    awful.key(
        {modkey, "Control"},
        "Return",
        function(c)
            c:swap(awful.client.getmaster())
        end,
        {description = "move to master", group = "client"}
    ),
    awful.key(
        {modkey},
        "o",
        function(c)
            c:move_to_screen()
        end,
        {description = "move to screen", group = "client"}
    ),
    awful.key(
        {modkey},
        "t",
        function(c)
            c.ontop = not c.ontop
        end,
        {description = "toggle keep on top", group = "client"}
    ),
    awful.key(
        {modkey},
        "n",
        function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        {description = "minimize", group = "client"}
    ),
    awful.key(
        {modkey},
        "m",
        function(c)
            awful.titlebar.toggle(c)
            c.maximized = true
            c:raise()
        end,
        {description = "(un)maximize", group = "client"}
    ),
    awful.key(
        {modkey, "Control"},
        "m",
        function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        {description = "(un)maximize vertically", group = "client"}
    ),
    awful.key(
        {modkey, "Shift"},
        "m",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        {description = "(un)maximize horizontally", group = "client"}
    ),
    -- Custom --

    -- Toggle titlebar
    awful.key(
        {modkey},
        "k",
        function(c)
            awful.titlebar.toggle(c)
        end,
        {description = "Toggle titlebar", group = "client"}
    )
)

return clientkeys
