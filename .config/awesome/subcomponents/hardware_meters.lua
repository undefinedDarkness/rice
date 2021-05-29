local M = {}

--- HARDWARE

-- RAM Meter {{{

M.ram_meter =
    wibox.widget {
    {
        widget = wibox.widget.textbox,
        text = "RAM",
        align = "center",
        forced_width = dpi(60),
        forced_height = dpi(60)
    },
    border_color = "#45403d",
    max_value = 100, -- DONT CHANGE
    min_value = 0,
    border_width = dpi(6),
    color = "#a9b665",
    widget = wibox.container.radialprogressbar
}

local ram_tooltip =
    awful.tooltip {
    objects = {M.ram_meter},
    text = "",
    bg = "#32302f",
    fg = "#d4be98",
    shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 3)
    end
}

awesome.connect_signal(
    "system::ram",
    function(used, total)
        M.ram_meter:set_value(math.ceil((used / total) * 100))
        ram_tooltip:set_text(used .. " / " .. total .. " mb")
    end
)

-- }}} 
-- CPU Meter {{{

M.cpu_meter =
    wibox.widget {
    {
        widget = wibox.widget.textbox,
        text = "CPU",
        align = "center",
        forced_width = dpi(60),
        forced_height = dpi(60)
    },
    border_color = "#45403d",
    max_value = 100, -- DONT CHANGE
    min_value = 0,
    border_width = dpi(6),
    color = "#7daea3",
    widget = wibox.container.radialprogressbar
}

local cpu_tooltip =
    awful.tooltip {
    objects = {M.cpu_meter},
    text = "",
    bg = "#32302f",
    fg = "#d4be98",
    shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 3)
    end
}

awesome.connect_signal(
    "system::cpu",
    function(percentage)
        M.cpu_meter:set_value(percentage)
        cpu_tooltip:set_text(percentage .. "%")
    end
)

-- }}} 
-- Harddrive Meter {{{

M.hdd_meter =
    wibox.widget {
    {
        {
            widget = wibox.widget.progressbar,
            shape = function(cr, w, h)
                gears.shape.rounded_rect(cr, w, h, 8)
            end,
            max_value = 100,
            min_value = 1,
            id = "bar",
            color = "#d3869b",
            background_color = "#2D2C2C" -- "#1d2021"
        },
        {widget = wibox.widget.textbox, text = "HDD", align = "center"},
        layout = wibox.layout.stack
    },
    widget = wibox.container.rotate,
    forced_height = 100,
    forced_width = 40,
    direction = "east"
}

awesome.connect_signal(
    "system::disk",
    function(used, total)
        M.hdd_meter:get_children_by_id("bar")[1]:set_value(math.ceil((used / total) * 100))
    end
)

-- }}} 
-- BATTERY / WIFI INDICATOR {{{

M.charge_indicator =
    wibox.widget {
    widget = wibox.widget.textbox,
    text = "??",
    font = _nerd_font
}

local battery_icons = {" ", " ", " ", " ", " ", " ", " ", " ", " ", " "}
awesome.connect_signal(
    "system::battery",
    function(percentage)
        local index = math.min(math.ceil(percentage / 10) * 10, 100) / 10
        M.charge_indicator:set_text(battery_icons[index])
    end
)

M.temp_indicator =
    wibox.widget {
    widget = wibox.widget.textbox,
    text = "??",
    font = _nerd_font
}

-- }}}
-- Temperature Indicator {{{

local temp_tooltip =
    awful.tooltip {
    objects = {M.temp_indicator},
    text = "",
    bg = "#32302f",
    fg = "#d4be98",
    shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 3)
    end
}

--              20    40    60    80    100
local temp_icons = {" ", " ", " ", " ", " "}

awesome.connect_signal(
    "system::temp",
    function(avgTemp)
        temp_tooltip:set_text(avgTemp .. "°C")
        local icon = ""

        if avgTemp <= 20 then
            icon = temp_icons[1]
        elseif avgTemp <= 40 then
            icon = temp_icons[2]
        elseif avgTemp <= 60 then
            icon = temp_icons[3]
        elseif avgTemp <= 80 then
            icon = temp_icons[4]
        else
            icon = temp_icons[5]
        end

        M.temp_indicator:set_text(icon)
    end
)

-- }}}

return M
