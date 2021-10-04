local rgba = require("misc.libs.stdlib").rgba
local dpi = require("beautiful.xresources").apply_dpi
--local user_home = os.getenv("HOME")

local themes_path = os.getenv("XDG_CONFIG_HOME") .. "/awesome/"

local theme = {}

theme.font = "Sarasa UI HC 10"

theme.bg_normal = "#1d1f21"
-- theme.bg_focus = "#535d6c"
theme.bg_lighter = "#32302f"
theme.bg_normal2 = "#282a2e"
theme.bg_highlight = "#3c3836"
theme.bg_lightest = "#45403d"

theme.bg_urgent = "#cc6666"
theme.bg_minimize = "#444444"
theme.bg_warning = "#f0c674"
theme.bg_good = "#b5bd68"

theme.transparent = "#00000000"

theme.fg_normal = "#e0e0e0"
theme.fg_focus = "#fafafa"
theme.fg_urgent = "#fafafa"
theme.fg_minimize = "#fafafa"
theme.fg_constrast = "#F5F5DC"

theme.useless_gap = dpi(8)
theme.systray_icon_spacing = dpi(8)
theme.bg_systray = theme.bg_normal2

theme.playerctl_backend = "playerctl_lib"

theme.tasklist_plain_task_name = true

theme.clock_format = "%a %d/%m - %I:%M%p"

-- BLING TAG PREVIEW
theme.tag_preview_widget_border_width = 0
theme.tag_preview_widget_border_width = 0
theme.tag_preview_client_border_width = 0
theme.tag_preview_client_bg = "#282a2e"
theme.tag_preview_widget_bg = "#fafafaaa"
theme.tag_preview_client_border_radius = 8

-- NOTIFICATIONS
theme.notification_spacing = dpi(16)

-- BLING TABS
theme.tabbar_font = "Sarasa UI HC 11"
theme.tabbar_position = "left"
theme.tabbar_style = "boxes"
theme.tabbar_ontop = false
theme.tabbar_bg_normal = "#282828"
theme.tabbar_bg_focus = "#3c3836"
theme.tabbar_disable = true

-- Bling Task Preview
theme.task_preview_widget_margin = dpi(0)
theme.task_preview_widget_border_width = dpi(0)
theme.task_preview_widget_bg = "#282828"
theme.task_preview_widget_border_radius = 8

-- SNAP SETTINGS
theme.snap_bg = "#f2e9de"
theme.snap_border_width = dpi(10)
theme.snap_shape = gears.shape.rectangle

theme.menu_submenu_icon = themes_path .. "theme/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

theme.titlebar_fg_normal = theme.fg_normal
theme.titlebar_fg_focus = theme.fg_normal
theme.titlebar_fg = theme.fg_normal

-- Assets
theme.wallpaper = themes_path .. "theme/assets/wallpaper.png"

theme.titlebar_close_button_normal = themes_path .. "theme/assets/close-normal.svg"
theme.titlebar_close_button_focus = themes_path .. "theme/assets/close-focus.svg"

theme.layout_floating = themes_path .. "theme/assets/layouts/floating.png"
theme.layout_tile = themes_path .. "theme/assets/layouts/tile.png"
theme.layout_dwindle = themes_path .. "theme/assets/layouts/dwindle.png"

theme.icon_theme = "Fluent"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
