local B = require("subcomponents.titlebar_buttons")

client.connect_signal(
    "request::titlebars",
    function(c)
        local titlewidget = awful.titlebar.widget.titlewidget(c)
        titlewidget.font = "Victor Mono Italic 0"

        -- buttons for the titlebar {{{
        local buttons =
            gears.table.join(
            awful.button(
                {},
                mouse.LEFT,
                function()
                    c:emit_signal("request::activate", "titlebar", {raise = true})
                    awful.mouse.client.move(c)
                    titlewidget.font = "Victor Mono Bold Italic 10"
                end
            ),
            awful.button(
                {},
                mouse.RIGHT,
                function()
                    c:emit_signal("request::activate", "titlebar", {raise = true})
                    awful.mouse.client.resize(c)
                end
            )
        )
        -- }}}

        local main =
            wibox.widget {
            {
                -- Title
                align = "center",
                widget = titlewidget
            },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal
        }
        main:connect_signal(
            "mouse::leave",
            function()
                titlewidget.font = "Victor Mono Italic 0"
            end
        )

        awful.titlebar(
            c,
            {
                size = 44,
                -- comment out for normal look
                bg_normal = "#1d2021",
                bg_focus = "#1d2021"
            }
        ):setup {
            nil,
            main,
            {
                -- Right
                --awful.titlebar.widget.maximizedbutton(c),
                B.custom_minimized_button(c),
                B.custom_maximized_button(c),
                B.custom_close_button(c),
                layout = wibox.layout.fixed.horizontal
            },
            layout = wibox.layout.align.horizontal
        }
    end
)
