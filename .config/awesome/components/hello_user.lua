local C = require("misc.custom")

local terminal_launch_cmd = terminal .. " -e "
if terminal == 'wezterm' then
    terminal_launch_cmd = "wezterm start "
end

function app_launcher(app_cmd, icon)
  icon = require("menubar.utils").lookup_icon(icon or gears.string.split(app_cmd, ' ')[1])
  local w = wibox.widget {
      widget = wibox.widget.imagebox,
      image = icon,
      resize = true,
      forced_height = 48,
      forced_width = 48
  }
  w:buttons(awful.button({}, 1, function() awful.spawn.with_shell(app_cmd) end))
  return w
end

-- CHANGE --
local gretting = "Hello, nes!"
local time = os.date('*t')
local hour = time.hour
if hour < 12+2 then
    greeting = "Good morning!"
elseif hour > 12+2 then
    greeting = "Good evening!"
elseif hour > 20 then
    greeting = "Good night!"
else
    greeting = "Good afternoon!"
end

local widget_structure = {
    {
        {
            {
                app_launcher("export GTK_THEME=Adwaita;firefox -P default-release", "firefox"),
                app_launcher(terminal_launch_cmd.."vim", "vim"),
                app_launcher("minecraft-launcher"),
                layout = wibox.layout.fixed.vertical,
                spacing = dpi(16)
            },
            widget = wibox.container.margin,
            margins = dpi(25)
        },
        bg = "#3c3836",
        widget = wibox.container.background
    },
    {
        {
            {
                -- PFP
                C.force_center {
                    widget = wibox.widget.imagebox,
                    clip_shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 8) end,
                    image = beautiful.pfp,
                    resize = true,
                    forced_height = 128,
                    forced_width = 128
                },
                -- GRETTING
                {
                    widget = wibox.widget.textbox,
                    font = "Sarasa UI HC Semibold 16",
                    markup = greeting
                },
                spacing = dpi(10),
                layout = wibox.layout.fixed.vertical
            },
            widget = wibox.container.margin,
            margins = 25
        },
        widget = wibox.container.background,
        bg = "#282828"
    },
    layout = wibox.layout.fixed.horizontal
}

awful.popup {
    placement = awful.placement.centered,
    shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 8) end,
    visible = true,
    bg = beautiful.transparent,
    widget = widget_structure,
    hide_on_right_click = true,
   -- input_passthrough = true
}
