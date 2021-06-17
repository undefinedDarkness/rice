-- Heavily inspired by javacafe's dotfiles (https://github.com/JavaCafe01/dotfiles/blob/master/.config/awesome/ui/notifs/init.lua)
local naughty = require("naughty")
local C = require("misc.custom")

naughty.config.padding = dpi(8)
naughty.config.spacing = dpi(16)

naughty.config.defaults.timeout = 8
naughty.config.defaults.title = "Hello There!"
naughty.config.defaults.position = "bottom_right"
naughty.config.defaults.icon_size = dpi(48)

naughty.config.icon_formats = {"png", "svg"}

naughty.connect_signal("request::icon", function(n, context, hints)
                           if context ~= "app_icon" then return end

                           local path = require("menubar.utils").lookup_icon(hints.app_icon) or
                               require("menubar.utils").lookup_icon(hints.app_icon:lower())

                           
                           if path then
                               n.icon = path
                           end
end)


naughty.connect_signal("request::display", function(n)
                           
                           n.timeout = 8
                           local time = os.date("%H:%M")

                           naughty.layout.box {
                               notification = n,
                               shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,16) end,
                               type = "notification",
                               minimum_width = 300,
                               maximum_width = 300,
                               border_width = dpi(1),
                               border_color = "#32302f",
                               widget_template = {
                                   {
                                       {    
                                           {

                                               {
                                                   {
                                                       widget = wibox.widget.imagebox,
                                                       image = n.icon,
                                                       resize = true,
                                                       forced_height = dpi(24),
                                                       forced_width = dpi(24)
                                                   },
                                                   widget = wibox.container.background,
                                                   --shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,8) end
                                               },
                                               {
                                                   widget = wibox.widget.textbox,
                                                   markup = " " .. n.title or n.app_name,
                                                   font = "Victor Mono Italic 12",
                                                   align = 'left'
                                               },
                                               C.force_right {
                                                   widget = wibox.widget.textbox,
                                                   align="right",
                                                   ---font = "Victor Mono 12",
                                                   markup = time 
                                               },
                                               layout = wibox.layout.align.horizontal
                                           },
                                           widget = wibox.container.margin,
                                           margins = dpi(12)
                                       },
                                       widget = wibox.container.background,
                                       bg = "#1d2021"
                                   },
                                   {
                                       {
                                           {
                                               widget = wibox.widget.textbox,
                                               text = n.message,--:gsub("\n", "  "), -- wrap naturally
                                               wrap = "word",
                                               font = beautiful.font
                                           },
                                           layout = wibox.container.margin,
					   margins = dpi(12)
				       },
                                       widget = wibox.container.background,
                                       bg = "#282828",
                                   },
                                   layout = wibox.layout.fixed.vertical
                               }
                           }
end)
