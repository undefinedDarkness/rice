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
        tray:set_base_size(28)
        -- }}}

        -- Create the wibox
        s.mywibar = awful.wibar {
            position = "left",
            screen = s,
            width = dpi(40),
            ontop = true,
            background = "#1d2021"
        }

        -- Wibar Layout {{{
        s.mywibar.widget = {
            {
                {
                    {
                        --[[{
                            {
                            require("misc.custom").force_center{
                            widget = wibox.widget.textbox,
                            text = "",
                            font = _nerd_font,
                            buttons = awful.button({},mouse.LEFT,function() awesome.spawn("rofi -show drun -theme drun")end)
                            },
                            widget = wibox.container.margin,
                            forced_height = dpi(24),
                            forced_width = dpi(24)},
                            widget = wibox.container.margin,
                            top = dpi(8),
                            bottom = dpi(8)
                            },]]--
                        widget = wibox.container.background,
                        bg = "#1d2021"
                    },
                    require("subcomponents.taglist")(s),
                    require("subcomponents.tasklist")(s),
                    s.mypromptbox,
                    layout = wibox.layout.fixed.vertical},
                bg = "#3c3836",
                widget = wibox.container.background,
                shape = function(cr,w,h) gears.shape.partially_rounded_rect(cr,w,h,false,false,true,true,16) end
            },
            {
                widget = wibox.container.margin,
                margins = 3
            },
            {
                require("subcomponents.power_menu")(s),
                {
                    tray,
                    widget = wibox.container.margin,
                    margins = dpi(6)
                },
                layout = wibox.layout.fixed.vertical
            },
            layout = wibox.layout.align.vertical,
            expand = "none"
        }
        -- }}}
    end
)
