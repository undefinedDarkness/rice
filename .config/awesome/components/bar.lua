-- Wallpaper Setter {{{
function set_wallpaper(s, wallpaper)
    -- Wallpaper
    if wallpaper then
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end
-- }}}

screen.connect_signal(
    "request::wallpaper",
    function(s)
        set_wallpaper(s, beautiful.wallpaper)
    end
)

screen.connect_signal(
    "request::desktop_decoration",
    function(s)
        -- Each screen has its own tag table.
        awful.tag(workspaces, s, awful.layout.layouts[1])

        -- Create an imagebox widget which will contain an icon indicating which layout we're using.
        -- LAYOUTBOX {{{
        s.mylayoutbox =
            awful.widget.layoutbox {
            screen = s,
            buttons = {
                awful.button(
                    {},
                    mouse.LEFT,
                    function()
                        awful.layout.inc(1)
                    end
                ),
                awful.button(
                    {},
                    mouse.RIGHT,
                    function()
                        awful.layout.inc(-1)
                    end
                ),
                awful.button(
                    {},
                    mouse.SCROLL_UP,
                    function()
                        awful.layout.inc(-1)
                    end
                ),
                awful.button(
                    {},
                    mouse.SCROLL_DOWN,
                    function()
                        awful.layout.inc(1)
                    end
                )
            }
        }
        -- }}}

        -- PROMPT BOX & TRAY {{{
        s.mypromptbox =
            awful.widget.prompt {
            prompt = "🚀: ",
            fg = "#d4be98",
            font = "Sarasa UI HC Italic 10"
        }

        local tray = wibox.widget.systray()
        tray:set_horizontal(false)
        -- }}}

        -- Create the wibox
        s.mywibar =
            awful.wibar {
            position = "right",
            screen = s,
            ontop = true,
            background = "#1d2021"
        }

        -- Wibar Layout {{{
        s.mywibar.widget = {
            {
                require("subcomponents.taglist")(s),
                s.mypromptbox,
                layout = wibox.layout.fixed.vertical
            },
            {
                require("subcomponents.tasklist")(s),
                widget = wibox.container.margin,
                margins = 3
            },
            {
                --textclock,
                tray,
                layout = wibox.layout.fixed.horizontal
            },
            layout = wibox.layout.align.vertical,
            expand = "none"
        }
        -- }}}
    end
)
