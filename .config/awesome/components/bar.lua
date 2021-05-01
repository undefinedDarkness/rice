screen.connect_signal("request::wallpaper", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)



screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag(workspaces, s, awful.layout.layouts[1])

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
        buttons = {
            awful.button({ }, mouse.LEFT, function () awful.layout.inc( 1) end),
            awful.button({ }, mouse.RIGHT, function () awful.layout.inc(-1) end),
            awful.button({ }, mouse.SCROLL_UP, function () awful.layout.inc(-1) end),
            awful.button({ }, mouse.SCROLL_DOWN, function () awful.layout.inc( 1) end),
        }
    }

    --[[local textclock = wibox.widget.textclock("%I:%M%P")
    textclock:connect_signal("button::press", function()
        if textclock.format == "%I:%M%P" then
            textclock.format = "%I:%M%P ~ %d/%m/%y"
        else
            textclock.format = "%I:%M%P"
        end
    end)--]]

    s.mypromptbox = awful.widget.prompt {
        prompt = "🚀: ",
        fg = "#d4be98",
        font = "Sarasa UI HC Italic 10"
    }

    -- Create the wibox
    s.mywibar = awful.wibar{
            position = "top",
            screen = s,
            ontop = true,
            background = "#1d2021"
        }

    -- Add widgets to the wibox
    s.mywibar.widget = {
        {
            require("subcomponents.taglist")(s),
            s.mypromptbox,
            layout = wibox.layout.fixed.horizontal
        },
        {
            require("subcomponents.tasklist")(s),
            widget = wibox.container.margin,
            margins = 3
        },
        {
            --textclock,
            wibox.widget.systray(),
            layout = wibox.layout.fixed.horizontal
        },
        layout = wibox.layout.align.horizontal,
        expand = "none"
    }
end)
-- }}}
