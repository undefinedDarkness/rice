-- Heavily inspired by javacafe's dotfiles (https://github.com/JavaCafe01/dotfiles/blob/master/.config/awesome/ui/notifs/init.lua)

local naughty = require("naughty")


naughty.connect_signal("request::display", function(n)
    local appicon = n.icon or n.app_icon or user_home .. "/.config/awesome/theme/notification.svg"
    local border_color = "#d8a657"

    if n.urgency == "low" then border_color = "#7daea3" elseif n.urgency == "critical" then border_color =  "#ea6962" end

    naughty.layout.box {
        notification = n,
        type = "notification",
        border_width = 4,
        hide_on_right_click = true,
        border_color = border_color,
        position = "bottom_right",
        widget_template = {
                {
                        {
                            {
                                widget = wibox.widget.imagebox,
                                resize = true,
                                image = appicon,
                                forced_height = 40,
                                forced_width = 40
                            },
                            widget = wibox.container.margin,
                            margins = 8
                        },
                        {
                            {
                                {
                                    widget = wibox.widget.textbox,
                                    font = "Sarasa UI HC Bold 12",
                                    text = n.title or "Your Attention Please"
                                },
                                {
                                    widget = wibox.widget.textbox,
                                    font = "Sarasa UI HC 11",
                                    text = n.message or n.text
                                },
                                layout = wibox.layout.align.vertical
                            },
                            widget = wibox.container.margin,
                            top = 10, 
                            left = 5,
                            right = 10,
                            bottom = 10
                        },
                        layout = wibox.layout.fixed.horizontal 
            }, 
            widget = wibox.container.background, 
            bg = "#282828" 
    }
}
end)
