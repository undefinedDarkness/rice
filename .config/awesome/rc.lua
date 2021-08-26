pcall(require, "luarocks.loader")

--[[
 _______                                            
|   _   |.--.--.--.-----.-----.-----.--------.-----.
|       ||  |  |  |  -__|__ --|  _  |        |  -__|
|___|___||________|_____|_____|_____|__|__|__|_____|
]]

-- 📚 Awesome Standard Library
gears = require("gears")
awful = require("awful")

-- Widget and layout library
wibox = require("wibox")

-- Theme handling library
beautiful = require("beautiful")

-- Config Directory
_config_dir = gears.filesystem.get_dir("config")

-- 🎨 Load Theme
beautiful.init(_config_dir .. "/theme/theme.lua")

-- Bling Widget Library
bling = require("misc.libs.bling")

-- DPI Function
dpi = require("beautiful.xresources").apply_dpi

-- Misc
require("awful.hotkeys_popup.keys")
require("awful.autofocus")

-- User Configuration

-- 🚀 Launch Script
awful.spawn.with_shell([[ $HOME/rice/misc/scripts/master.sh launch ]])

-- 🔨 Variable definitions

terminal = "st"

-- Mod1 = Alt, Mod4 = Windows Key, See: `xmodmap`
modkey = "Mod1"

-- For Convienience
workspaces = { "", "", "" }

mouse.LEFT = 1
mouse.MIDDLE = 2
mouse.RIGHT = 3
mouse.SCROLL_UP = 4
mouse.SCROLL_DOWN = 5

_nerd_font = "Arimo Nerd Font 12"

-- Window Layouts
tag.connect_signal("request::default_layouts", function()
	awful.layout.append_default_layouts({
		awful.layout.suit.floating,
		awful.layout.suit.tile,
		awful.layout.suit.spiral.dwindle,
	})
end)

-- Load Components
require("components.titlebar")
require("components.notifications")
require("components.bar")

-- Load Global Keybindings
require("misc.keybindings.global")

-- Load Misc
require("misc.platform")
