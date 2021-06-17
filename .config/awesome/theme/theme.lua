---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local rgba = require("misc.custom").rgba
local dpi = require("beautiful.xresources").apply_dpi
local user_home = os.getenv("HOME")

local themes_path = user_home .. "/.config/awesome/"

local theme = {}

theme.font = "Sarasa UI HC 10"

theme.bg_normal = "#1d2021"
theme.bg_focus = "#535d6c"

theme.titlebar_bg_normal = "#3c3836"
theme.titlebar_bg_focus = "#32302f"

theme.bg_urgent = "#ff0000"
theme.bg_minimize = "#444444"
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#d4be98"
theme.fg_focus = "#ffffff"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

theme.useless_gap = dpi(8)

-- BORDER CONFIG

theme.border_width = dpi(1)
theme.border_normal = "#3c3836"
theme.border_focus = "#32302f"
theme.border_marked = "#91231c"

-- END

theme.tasklist_plain_task_name = true

-- BLING TAG PREVIEW CONFIG

theme.tag_preview_widget_bg = "#282828"
theme.tag_preview_widget_border_radius = dpi(3)
theme.tag_preview_widget_border_color = "#45403d"
theme.tag_preview_widget_margin = dpi(8)
theme.tag_preview_client_border_width = dpi(3)
theme.tag_preview_client_border_color = "#45403d"
theme.tag_preview_client_bg = "#1d2021"
theme.tag_preview_client_border_radius = dpi(3)

-- END

-- NOTIFICATION CONFIG

theme.notification_spacing = dpi(16)

-- END

-- BLING TABS

theme.tabbar_font = "Sarasa UI HC 11"
theme.tabbar_position = "left"
theme.tabbar_style = "boxes"
theme.tabbar_ontop = false
theme.tabbar_bg_normal = "#282828"
theme.tabbar_bg_focus = "#3c3836"

-- END

theme.transparent = "#00000000"

-- SNAP SETTINGS

theme.snap_bg = "#ea6962"
theme.snap_border_width = dpi(10)
theme.snap_shape = gears.shape.rectangle

-- END

theme.menu_submenu_icon = themes_path .. "theme/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

theme.titlebar_fg_normal = theme.fg_normal
theme.titlebar_fg_focus = theme.fg_normal
theme.titlebar_fg = theme.fg_normal

theme.titlebar_close_button_normal = themes_path .. "theme/titlebar/close_normal.png"
theme.titlebar_close_button_focus = themes_path .. "theme/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path .. "theme/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = themes_path .. "theme/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path .. "theme/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = themes_path .. "theme/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "theme/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = themes_path .. "theme/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path .. "theme/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = themes_path .. "theme/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "theme/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = themes_path .. "theme/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path .. "theme/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = themes_path .. "theme/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path .. "theme/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = themes_path .. "theme/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "theme/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = themes_path .. "theme/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "theme/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = themes_path .. "theme/titlebar/maximized_focus_active.png"

theme.wallpaper = themes_path .. "theme/stairs.jpg"

theme.lockscreen_wallpaper = themes_path .. "theme/camera.jpg"
theme.pfp = themes_path .. "theme/pfp.png"

theme.layout_floating = themes_path .. "theme/layouts/floatingw.png"
theme.layout_tile = themes_path .. "theme/layouts/tilew.png"
theme.layout_dwindle = themes_path .. "theme/layouts/dwindlew.png"

theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)
theme.icon_theme = "Papirus"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
