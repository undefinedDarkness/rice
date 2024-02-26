-- -*- eval: (rainbow-mode 1); -*-

local color = require('platform.stdlib').color
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


theme.titlebar_bg = '#fde249'
theme.titlebar_bg_focus = '#fc833a'
theme.wibar_bg = '#111111'
theme.wibar_fg = '#fafafa'
theme.bg_systray = theme.wibar_bg
theme.tasklist_bg_normal = theme.wibar_bg
theme.menubar_bg_normal = theme.wibar_bg
theme.menubar_fg_normal = '#fafafa'

-- theme.menu_bg = '#262322'
-- theme.menu_section_bg = '#859e82'

theme.prompt_bg = theme.fg_normal
theme.prompt_fg = theme.bg_light
theme.prompt_bg_cursor = theme.bg_gray

-- Tasklist Status Icons
theme.tasklist_maximized = ' &lt;<b>M</b>&gt; '

-- Other
theme.useless_gap = dpi(8)
theme.gap_single_client = false
theme.systray_icon_spacing = dpi(8)
theme.font = 'Ubuntu Nerd Font'
theme.workspaces = { 'I', 'II', 'III', 'IV', 'V' }

theme.separator_color = '#2a2a2a'

-- Settings
theme.terminal = 'xterm'
theme.tabbar_disable = true
theme.on_startup = {
	'sh ~/rice/scripts/master.sh startup',
	'picom -b -c -C',
	'xrdb -load ~/rice/Xresources',
	'nm-applet',
}

-- Notifications
theme.notification_spacing = dpi(16)
theme.notification_fg = '#f0f0f0'
theme.notification_bg = '#111111'
theme.notification_icon_size = 64
theme.notification_position = 'bottom_right'

-- Window Snapping
theme.snap_bg = beautiful.fg_inactive
theme.snap_border_width = dpi(10)
theme.snap_shape = gears.shape.rectangle

local assets = themes_path .. 'assets/'

-- Layout Icons
theme.layout_floating = assets .. 'layouts/floating.png'
theme.layout_tile = assets .. 'layouts/tile.png'
theme.layout_dwindle = assets .. 'layouts/dwindle.png'

theme.titlebar_close_button_normal = assets .. 'icons/close.svg'
theme.titlebar_close_button_focus = assets .. 'icons/close-f.svg'

theme.wallpaper = assets .. 'city.jpg'

theme.icon_theme = 'Adwaita++ Dark'

return theme
