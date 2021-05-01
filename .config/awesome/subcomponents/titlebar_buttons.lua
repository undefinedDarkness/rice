local C = require("misc.custom")

local M = {}

function M.custom_maximized_button(c)

    local colr = '#689d6a'

    local buttons = gears.table.join(
        awful.button({}, mouse.LEFT, function()
           c.maximized = not state
           state = not state
        end))

    local widget = C.hover_effect({
        {
            {
            nil,
            {
                {
                    widget = wibox.container.background,
                    forced_width = 4,
                    forced_height = 4
                },
                widget = wibox.container.margin,
                margins = 2,
                id = "icon",
                color = colr
            },
            nil,
            layout = wibox.layout.align.vertical,
            expand = "none"
        },
        widget = wibox.container.margin,
        left = 16,
        right = 16
    },
    widget = wibox.widget.background
    }, function(w, m)
        if m then
            w.bg = colr
            w:get_children_by_id("icon")[1].color = '#00000080'
        else
            w.bg = beautiful.transparent
            w:get_children_by_id("icon")[1].color = colr
        end
    end)

    widget:buttons(buttons)
    return widget
end

function M.custom_minimized_button(c)

    -- This only works on right click for some stupid reason
    local buttons = gears.table.join(
        awful.button({}, mouse.RIGHT, function()
            c.minimized = not c.minimized
        end))

    local colr = '#d79921'

    local widget = C.hover_effect({
        {
            {
            nil,
            {
                widget = wibox.container.background,
                bg = colr,
                forced_width = 10,
                forced_height = 3,
                id = 'icon'
            },
            nil,
            layout = wibox.layout.align.vertical,
            expand = "none"
        },
        widget = wibox.container.margin,
        left = 16,
        top = 5,
        right = 16
    },
    widget = wibox.widget.background
    }, function(w, m)
        if m then
            w.bg = colr
            w:get_children_by_id("icon")[1].bg = '#00000080'
        else
            w.bg = beautiful.transparent
            w:get_children_by_id("icon")[1].bg = colr
        end
    end)

    widget:buttons(buttons)
    return widget
end


function M.custom_close_button(c)

    local buttons = gears.table.join(
        awful.button({}, mouse.LEFT, function()
            c:kill()
        end))

    local widget = C.hover_effect({
    {
        {
            nil,
            {

                widget = wibox.container.background,
                -- Definately not stolen from java's dots
                shape = gears.shape.transform(gears.shape.cross):rotate_at(6.5, 6.5, math.pi / 4),
                forced_width = 12,
                id = 'icon',
                bg = '#d94331',
                forced_height = 12
            },
            nil,
            layout = wibox.layout.align.vertical,
            expand = "none"
        },
        widget = wibox.container.margin,
        left = 16,
        right = 16
    },
    widget = wibox.container.background
    }, function(w, m)
            if m then
                w.bg = "#d94331"
                w:get_children_by_id("icon")[1].bg ='#00000080'
            else 
                w.bg = beautiful.transparent
                w:get_children_by_id("icon")[1].bg ='#d94331'
            end
        end)

    widget:buttons(buttons)
    
    return widget
end

return M
