local get_icon = require("menubar.utils").lookup_icon
return function(s)

   local menu = awful.popup {
      visible = false,
      hide_on_right_click = true,
      widget = wibox.widget {
         {
            {
                widget = wibox.widget.imagebox,
                image = get_icon("system-shutdown"),
                forced_height = dpi(24),
                buttons = awful.button({}, mouse.LEFT, function() awful.spawn("systemctl poweroff") end),
                forced_width = dpi(24),
                resize = true
            },
            {
                widget = wibox.widget.imagebox,
                image = get_icon("system-log-out"),
                forced_height = dpi(24),
                buttons = awful.button({}, mouse.LEFT, function() awesome.quit() end),
                forced_width = dpi(24),
                resize = true
            },
            {
                widget = wibox.widget.imagebox,
                image = get_icon("system-restart"),
                forced_height = dpi(24),
                buttons = awful.button({}, mouse.LEFT, function() awful.spawn("systemctl reboot") end),
                forced_width = dpi(24),
                resize = true
            },
            spacing = dpi(8),
         layout = wibox.layout.fixed.vertical
       },
       widget = wibox.container.margin,
       left = dpi(8),
       right = dpi(8),
       top = dpi(12),
       bottom = dpi(12)
      },
      ontop = true,
      shape = gears.shape.rounded_bar,
      placement = function(x) awful.placement.bottom_left(x, {honor_workarea=true,margins={bottom=25,left=25}}) end
   }
   
   return wibox.widget {
      widget = wibox.widget.textbox,
      font = "Arimo Nerd Font 15",
      text = "臘",
      align = "center",
      buttons = awful.button({}, mouse.LEFT, function() menu.visible = not menu.visible end)
   }
   
end
