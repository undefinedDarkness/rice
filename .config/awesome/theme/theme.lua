local rgba = require("misc.libs.stdlib").rgba
local dpi = require("beautiful.xresources").apply_dpi
local themes_path = _config_dir .. "theme/"

local theme = {}

-- Colors
theme.transparent = "#00000000"
theme.fg_inactive = '#575279'
theme.fg_red = "#d7827e"
theme.fg_subtle = "#6e6a86"
theme.fg_magenta = "#9893a5"
theme.fg_blue = "#56949f" 
theme.bg_overlay = "#f2e9de"

-- Other
theme.useless_gap = dpi(8)
theme.systray_icon_spacing = dpi(8)
theme.font = "UnifontMedium Nerd Font"
theme.titlebar_font = "CozetteVector"

-- Settings
theme.terminal = 'st'
theme.on_startup =  '$HOME/etc/rice/misc/scripts/master.sh launch'
theme.on_screenshot = 'scrot -s -b ~/screenshot.png'

-- Notifications
theme.notification_spacing = dpi(16)

-- Window Snapping
theme.snap_bg = beautiful.fg_inactive
theme.snap_border_width = dpi(10)
theme.snap_shape = gears.shape.rectangle

-- Layout Icons
theme.layout_floating = themes_path .. "assets/layouts/floating.png"
theme.layout_tile = themes_path .. "assets/layouts/tile.png"
theme.layout_dwindle = themes_path .. "assets/layouts/dwindle.png"

return theme
