local C = require("misc.custom")
local B = require("subcomponents.sidebar_bits")


function section_header(txt)
    return wibox.widget {
        C.force_left {
            widget = wibox.widget.textbox,
            markup = C.colorify("#45403d", string.upper(txt)),
            font = "Sarasa UI HC Bold 10"
        },
        widget = wibox.container.margin,
        top = 12,
        bottom = 5
    }
end

local main_widget = wibox.widget {
    {
        section_header("DATE / TIME"),
        -- CLOCK
        {
            C.force_center {
                {
                    widget = wibox.widget.textclock,
                    format = '<span font="Sarasa UI HC 20">%I:%M</span><span font="Sarasa UI HC 15">%p</span>'
                },
                widget = wibox.container.margin,
                margins = 10
            },
            widget = wibox.container.background,
            bg = "#32302f",
            shape = function(cr, w, h)
                gears.shape.rounded_rect(cr, w, h, 12)
            end
        },
        {
            {
                -- DATE
                {
                    {
                        C.force_center {
                            widget = wibox.widget.textclock,
                            format = "<span foreground='#32302f' font='Sarasa Term K 10'>%d-%m-%y</span>"
                        },
                        widget = wibox.container.margin,
                        left = 8,
                        top = 8,
                        bottom = 8,
                        right = 8
                    },
                    bg = "#d8a657",
                    widget = wibox.container.background,
                    shape = gears.shape.rounded_bar
                },
                -- WEATHER
                {
                    {
                        C.force_center (B.weather_widget),
                        widget = wibox.container.margin,
                        left = 8,
                        top = 8,
                        bottom = 8,
                        right = 8
                    },
                    bg = "#ea6962",
                    widget = wibox.container.background,
                    shape = gears.shape.rounded_bar
                }, 
                spacing = 10,
                layout = wibox.layout.flex.horizontal
            },
            top = 10,
            bottom = 10,
            widget = wibox.container.margin
        },
        -- MUSIC WIDGET
        section_header("NOW PLAYING"),
        {
            B.music_image_widget,
            widget = wibox.container.constraint,
            height = 200,
            width = nil,
        },
        {
            {
                {
                    C.hover_effect({
                        text = "玲",
                        align = "right",
                        font = _nerd_font,
                        widget = wibox.widget.textbox,
                        buttons = awful.button({}, mouse.LEFT, function()
                                awful.spawn("playerctl previous")
                            end)
                    }, B.highlight_txt),
                    B.play_pause,
                    C.hover_effect({
                        text = "怜",
                        font = _nerd_font,
                        align = "left",
                        widget = wibox.widget.textbox,
                        buttons = awful.button({}, mouse.LEFT, function()
                                awful.spawn("playerctl next")
                            end)
                    }, B.highlight_txt),
                    layout = wibox.layout.flex.horizontal
                },
                widget = wibox.container.margin,
                left = 12,
                right = 12,
                top = 8,
                bottom = 8
            },
            widget = wibox.container.background,
            bg = "#32302f",
            shape = function(cr, w, h)
                gears.shape.partially_rounded_rect(cr, w, h, false, false, true,
                                                   true, 12)
            end
        },
        {
            {
                C.force_left {
                    widget = wibox.widget.textbox,
                    markup = C.colorify("#45403d", string.upper("HARWARE")),
                    font = "Sarasa UI HC Bold 10"
                },
                C.force_right(C.hover_effect({
                    widget = wibox.widget.textbox,
                    font = "Arimo Nerd Font Bold 13",
                    markup = '<span color="#45403d"> </span>',
                    buttons = awful.button({}, 1, function() 
                        awful.spawn.easy_async_with_shell('echo -e "Shutdown\nRestart\nLogout\nLockscreen" | dmenu -p " "  -h 30 -c', function(out)
                            out = out:gsub("\n", "") 
                            if string.find(out, "Shutdown") then 
                                awful.spawn("systemctl poweroff")
                            elseif string.find(out, "Restart") then
                                awful.spawn("systemctl reboot")
                            elseif string.find(out, "Logout") then
                                awesome.quit()
                            elseif string.find(out, "Lockscreen") then
                                 require("components.lockscreen").init()
                                 lock_screen_show()
                            end
                        end)
                    end)
                }, B.highlight_txt)),
                layout = wibox.layout.flex.horizontal
            },
            widget = wibox.container.margin,
            top = 10,
            bottom = 5
        },
        {
            {
                -- TODO: Add meters using radial progress container
                B.ram_meter,
                B.cpu_meter,
                widget = wibox.layout.flex.vertical,
                spacing = 15
            },
            {
                B.charge_indicator,
                B.temp_indicator,
                layout = wibox.layout.flex.vertical,
                spacing = 15
            },
            B.hdd_meter,
            spacing = 20,
            layout = wibox.layout.fixed.horizontal
        },
        {
            {
                C.force_left {
                    widget = wibox.widget.textbox,
                    markup = C.colorify("#45403d", string.upper("TODO")),
                    font = "Sarasa UI HC Bold 10"
                },
                {
                    nil,
                    C.hover_effect({
                        widget = wibox.widget.textbox,
                        font = "Arimo Nerd Font Bold 13",
                        markup = '<span color="#45403d"> </span>',
                        buttons = awful.button({}, 1, function() 
                            B.show_notifications()
                        end)
                    }, B.highlight_txt),
                    C.hover_effect({
                        widget = wibox.widget.textbox,
                        font = "Arimo Nerd Font Bold 13",
                        markup = '<span color="#45403d">樂</span>',
                        buttons = awful.button({}, 1, function() 
                            awful.spawn.easy_async_with_shell("~/Documents/Scripts/todo.sh add-task-gui", function()
                                B.update_tasklist()
                            end)
                        end)
                    }, B.highlight_txt),
                    layout = wibox.layout.align.horizontal,
                    expand = "none"
                },
                layout = wibox.layout.flex.horizontal
            },
            widget = wibox.container.margin,
            top = 10,
            bottom = 5
        },
        B.todo_items,
        C.force_center(B.layout_box),
        layout = wibox.layout.fixed.vertical
    },
    widget = wibox.container.margin,
    left = 25,
    right = 25,
    top = 35,
    bottom = 35
}

local main = wibox({
    type = "splash", -- change this if neccessary
    width = 250,
    visible = true,
    bg = "#282828",
    height = 1000,
    screen = awful.screen.focused(),
    widget = main_widget
})
awful.placement.right(main, { margins = { top = 100, right = 25 } })
