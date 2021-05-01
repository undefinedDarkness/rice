local C = require("misc.custom")

local M = {}

M.highlight_txt = function(w, m)
    if m then
        w.original_markup = w.markup or w.text
        w.markup = require("misc.custom").colorify("#fafafa", w.text)
    else
        w.markup = w.original_markup
    end
end

--- WEATHER WIDGET
-- CHANGE
local city = "Panjim"

M.weather_widget = wibox.widget {
    widget = wibox.widget.textbox,
    text = "Strange",
    font = "Sarasa Term K 10"
}

awful.spawn.easy_async("curl -s 'wttr.in/" .. city .. "?format=%c+%f'",
    function(out, _, _, _)
        if string.len(out) > 0 then
            out = out:gsub("  ", " ")
            out = out:gsub("\n", "")
            M.weather_widget.markup = C.colorify('#32302f', out)
        end
    end)

--- MUSIC WIDGET

playerctl_state = {
    image = user_home .. "/.config/awesome/theme/record.jpg",
    playing = "Nothing Playing.",
    _playing = "契"
}
M.play_pause = C.hover_effect({
    widget = wibox.widget.textbox,
    text = "契",
    align = "center",
    font = _nerd_font,
    buttons = awful.button({}, mouse.LEFT, function()
        awful.spawn("playerctl play-pause")
    end)
}, M.highlight_txt)


M.music_image_widget = wibox.widget {
    widget = wibox.widget.imagebox,
    resize = true,
    image = gears.surface.load_uncached(playerctl_state.image),
    clip_shape = function(cr, w, h)
        gears.shape
            .partially_rounded_rect(cr, w, h, true, true, false, false, 8)
    end
}

M.music_image_widget:buttons(
    awful.button({}, mouse.MIDDLE, function()
        M.music_image_widget:set_image(gears.surface.load_uncached(user_home .. "/.config/awesome/theme/record.jpg"))
        playerctl_state.image = user_home .. "/.config/awesome/theme/record.jpg"
    end)
)

local music_title_tooltip = awful.tooltip {
    objects = {M.music_image_widget},
    text = playerctl_state.playing,
    bg = "#32302f",
    fg = "#d4be98",
    shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 3) end
}

bling.signal.playerctl.enable()
awesome.connect_signal("bling::playerctl::title_artist_album",
    function(title, artist, image)
        music_title_tooltip.text = title .. " ~ " .. artist
        M.music_image_widget:set_image(gears.surface.load_uncached(image))
        -- Update state
        playerctl_state.playing = title .. " ~ " .. artist
        playerctl_state.image = image
    end)

awesome.connect_signal("bling::playerctl::status", function(x)
    if x then
        M.play_pause.text = ""
        playerctl_state._playing = ""
    else
        M.play_pause.text = "契"
        playerctl_state._playing =  "契"
    end
end)



-- TODO!

local todo_script = "deno run --allow-read --allow-run --allow-write /home/david/Documents/Scripts/todo/todo.ts "

M.todo_items = wibox.widget {
    layout = wibox.layout.fixed.vertical,
    spacing = 8,
    forced_height = 250
}

function todo_item(id, title, txt, widget_index)
    return C.hover_effect({
        {
            {
                {
                        {
                        {
                            widget = wibox.widget.textbox,
                            text = title,
                            font = "Sarasa UI HC Bold 12"
                        },
                        {
                            widget = wibox.widget.textbox,
                            text = txt,
                        },
                        layout = wibox.layout.flex.vertical,
                    },
                    widget = wibox.container.constraint,
                    width = dpi(160)
                },
                {
                    widget = wibox.widget.textbox,
                    text = " ",
                    visible = false,
                    align = "right",
                    id = "finish_task_btn",
                    buttons = awful.button({}, 1, function()
                        M.todo_items:remove(widget_index)
                        awful.spawn(todo_script .. "complete-task " .. id)
                    end),
                    font = _nerd_font,
                },
                layout = wibox.layout.fixed.horizontal,
                spacing = dpi(40)
            },
            widget = wibox.container.margin,
            top = 6,
            bottom = 6,
            left = 14,
            right = 6
        },
        widget = wibox.container.background,
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 8) end,
    }, function(w, b)
        if b then
            w.bg = "#32302f"
            w:get_children_by_id("finish_task_btn")[1].visible = true
        else
            w:get_children_by_id("finish_task_btn")[1].visible = false
            w.bg = beautiful.transparent
        end
    end)
end


M.update_tasklist = function()
    awful.spawn.easy_async_with_shell(todo_script .. "output-awesome", function(out)
        out = out:gsub("\n", "")

        if out == "EMPTY" then
            return
        end

        local tasks = gears.string.split(out, "?")
        M.todo_items:reset() -- remove all items!

        for i, v in ipairs(tasks) do
            local td = gears.string.split(v, ":")
            M.todo_items:add(todo_item(td[1], td[2], td[3], i))
        end
    end)
end

M.update_tasklist()

M.layout_box = awful.widget.layoutbox()
M.layout_box.forced_width = 25
M.layout_box.forced_height = 25


return gears.table.join(M, require("subcomponents.hardware_meters"))

