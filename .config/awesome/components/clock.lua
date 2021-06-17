local box = wibox {
    visible = true,
    screen = awful.screen.focused(),
    width = dpi(300),
    height = dpi(200),
    type = 'splash',
    widget = wibox.widget {
        {
            valign = 'bottom',
            align = 'center',
            format = "%a %d/%m - %I:%M%p",
            widget = wibox.widget.textclock,
            font = "Victor Mono Italic 20"
        },
        widget = wibox.container.background,
        fg = "#fafafa"
     },
    bg = '#00000000'
}

awful.placement.bottom(box,{margins={bottom = dpi(30)}})
