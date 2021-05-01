--- MY LIST OF SMOL HELPER FUNCTIONS

local M = {}

function is_widget(w) 
    if w["connect_signal"] ~= nil then
        return w
    else
        return wibox.widget(w)
    end
end

-- Courtesy of no37
function M.hexagon_shape(cr, width, height)
    temp = 0
    if width > height then temp = height else temp = width end
    cr:move_to(temp/2, 0)
    cr:line_to(temp, temp * 3/11)
    cr:line_to(temp, temp * 8/11)
    cr:line_to(temp/2, temp)
    cr:line_to(0, temp * 8/11)
    cr:line_to(0, temp * 3/11)
    cr:close_path()
end

function M.colorify(color, txt)
    return "<span color=\"" .. color .. "\">" .. txt .. "</span>"
end

function M.rgba(r, g, b, a)
    return string.format("#%x%x%x%x", r, g, b, math.ceil(a or 0 * 256))
end

function M.trim_string(x)
    return (x:gsub("^%s*(.-)%s*$", "%1"))
end



function M.force_left(x)
    return wibox.widget {
        x,
        nil,
        nil,
        layout = wibox.layout.align.horizontal,
        expand = "none"
    }
end

function M.force_center(x)
    return wibox.widget {
        nil,
        x,
        nil,
        layout = wibox.layout.align.horizontal,
        expand = "none"
    }
end

function M.force_right(x)
    return wibox.widget {
        nil,
        nil,
        x,
        layout = wibox.layout.align.horizontal,
        expand = "none"
    }
end



function M.hover_effect(w, exe)
    w = is_widget(w)
    w:connect_signal("mouse::enter", function() exe(w, true) end)
    w:connect_signal("mouse::leave", function() exe(w, false) end)
    return w
end



return M
