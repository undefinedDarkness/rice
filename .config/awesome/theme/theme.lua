-- -*- eval: (rainbow-mode 1); -*-

local color = require('misc.libs.stdlib').color
local dpi = require('beautiful.xresources').apply_dpi
local themes_path = _config_dir .. 'theme/'

local theme = {}

-- Colors
theme.bg_normal = '#ff0000'
theme.bg_shadow = '#111111'
theme.fg_normal = '#181818'
theme.bg_light = '#fafafa'
theme.bg_wall = '#f7f3e8'
theme.fg_grey = '#b0b0b0'

theme.titlebar_bg_focus = '#FF7538'
theme.titlebar_bg = '#1a1a1a'
theme.wibar_bg = '#FFF5EE'
theme.bg_systray = theme.wibar_bg
theme.tasklist_bg_normal = theme.wibar_bg
theme.menubar_bg_normal = theme.wibar_bg

-- theme.menu_bg = '#262322'
-- theme.menu_section_bg = '#859e82'

theme.prompt_bg = theme.fg_normal
theme.prompt_fg = theme.bg_light
theme.prompt_bg_cursor = theme.bg_gray

-- Tasklist Status Icons
theme.tasklist_maximized = ' &lt;<b>M</b>&gt; '

-- Other
theme.wibar_top_border_width = dpi(2)
theme.useless_gap = dpi(8)
theme.systray_icon_spacing = dpi(8)
theme.font = 'IBM Plex Sans'
theme.workspaces = { 'α', 'β', 'γ', 'δ', 'σ' }

theme.separator_color = '#2a2a2a'

-- Settings
theme.terminal = 'xterm -geometry 50x20'
theme.tabbar_disable = true
theme.clock_fmt = '<b>%R</b>' -- TODO: Use semibold / medium
theme.on_startup = { 'picom -b -c -C', 'xrdb -load ~/rice/Xresources', 'nm-applet' }

-- Notifications
theme.notification_spacing = dpi(16)
theme.notification_bg = '#f0f0f0'
theme.notification_fg = '#282828'
theme.notification_icon_size = 64

-- Window Snapping
theme.snap_bg = beautiful.fg_inactive
theme.snap_border_width = dpi(10)
theme.snap_shape = gears.shape.rectangle

local assets = themes_path .. 'assets/'

-- Layout Icons
theme.layout_floating = assets .. 'layouts/floating.png'
theme.layout_tile = assets .. 'layouts/tile.png'
theme.layout_dwindle = assets .. 'layouts/dwindle.png'

theme.wallpaper = assets .. 'buildings.jpg'

return theme
