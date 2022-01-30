local color = require('misc.libs.stdlib').color
local dpi = require('beautiful.xresources').apply_dpi
local themes_path = _config_dir .. 'theme/'

local theme = {}

-- Colors
theme.wallpaper_bg = '#E5CEAE'
theme.wallpaper_fg = '#E5CEAE'
theme.titlebar_bg_focus = '#d9b27c'
theme.titlebar_bg_normal = '#ab9382'
theme.menu_bg = '#262322'
theme.bg_normal = '#ff0000'
theme.menu_section_bg = '#859e82'
theme.wibar_bg = '#f7f3ea'
theme.tasklist_bg_normal = theme.wibar_bg
theme.bg_systray = theme.wibar_bg
theme.fg_normal = '#181818'
theme.wibar_top_border_width = 2
-- theme.wibar_border_color = "#181818"

-- Tasklist Status Icons
theme.tasklist_maximized = ' &lt;<b>M</b>&gt; '

-- Other
theme.useless_gap = dpi(8)
theme.systray_icon_spacing = dpi(8)
theme.font = 'Commissioner Regular'
-- theme.titlebar_font = 'Roboto Medium'
theme.workspaces = { 'Hephaestus', 'Apollo', 'Hermes' }

-- Settings
theme.terminal = 'xterm -geometry 50x20'
theme.tabbar_disable = true
theme.clock_fmt = '<b>%R</b>'
theme.on_startup = { 'picom -b -c -C' }

-- Notifications
theme.notification_spacing = dpi(16)

-- Window Snapping
theme.snap_bg = beautiful.fg_inactive
theme.snap_border_width = dpi(10)
theme.snap_shape = gears.shape.rectangle

-- Layout Icons
theme.layout_floating = themes_path .. 'assets/layouts/floating.png'
theme.layout_tile = themes_path .. 'assets/layouts/tile.png'
theme.layout_dwindle = themes_path .. 'assets/layouts/dwindle.png'

-- theme.day_icon = themes_path .. 'assets/icons/day.png'

return theme
