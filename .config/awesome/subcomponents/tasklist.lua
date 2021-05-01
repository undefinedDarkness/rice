
return function(s)
    return awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        layout = {
            layout = wibox.layout.fixed.horizontal,
            spacing = 12
        },
        widget_template = {
            widget = awful.widget.clienticon,
            id = 'client_icon',
            create_callback = function(self, c, _, _)
                --self:get_children_by_id('client_icon')[1].client = c
                self.client = c

                local tooltip = awful.tooltip {
                    objects = { self },
                    text = c.name,
                    --mode = "outside",
                    --border_width = 1,
                    --border_color = "#d4be98",
                    bg = "#32302f",
                    fg = "#d4be98",
                    shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 3) end
                }

            end,
        },
        buttons = {
            awful.button({ }, mouse.LEFT, function (c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
            awful.button({ }, mouse.RIGHT, function() awful.menu.client_list { theme = { width = 250 } } end),
            awful.button({ }, mouse.SCROLL_UP, function() awful.client.focus.byidx(-1) end),
            awful.button({ }, mouse.SCROLL_DOWN, function() awful.client.focus.byidx( 1) end),
        }
    }
end
