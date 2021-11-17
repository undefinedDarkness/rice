local color = require("misc.libs.stdlib").color
local dpi = require("beautiful.xresources").apply_dpi
local themes_path = _config_dir .. "theme/"

local theme = {}

-- Colors
theme.wallpaper_bg = "#fafafa"
theme.wallpaper_fg = "#fafafa"
theme.titlebar_bg_normal = "#dfaf8f"
theme.titlebar_bg_focus = "#ffd7a7"
theme.titlebar_fg_normal = color.darken(theme.titlebar_bg_normal, 48)
theme.titlebar_fg_focus = color.darken(theme.titlebar_bg_focus, 48)

-- Other
theme.useless_gap = dpi(8)
theme.systray_icon_spacing = dpi(8)
theme.font = "Roboto Medium"
theme.workspaces = { "Hephaestus", "Apollo", "Hermes" }

-- Settings
theme.terminal = "st"
theme.tabbar_disable = true
theme.on_startup = "$HOME/rice/scripts/master.sh launch"
theme.on_screenshot = "scrot -s -b ~/screenshot.png"

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
