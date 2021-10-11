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
wibox = require("wibox")
beautiful = require("beautiful")

-- Config Directory
_config_dir = gears.filesystem.get_dir("config")
dpi = require("beautiful.xresources").apply_dpi

-- 🎨 Load Theme
beautiful.init(_config_dir .. "/theme/theme.lua")

-- Bling Widget Library
bling = require("misc.libs.bling")

-- Misc
require("awful.hotkeys_popup.keys")
require("awful.autofocus")

-- Post Init

-- 🚀 Launch Script
awful.spawn.with_shell(beautiful.on_startup)

-- For Keybindings

-- Mod1 = Alt
-- Mod4 = Windows Key
-- See: `xmodmap`
modkey = "Mod1"

mouse.LEFT = 1
mouse.MIDDLE = 2
mouse.RIGHT = 3
mouse.SCROLL_UP = 4
mouse.SCROLL_DOWN = 5

-- Load Components
require("components.titlebar")
require("components.notifications")

-- Load Global Keybindings
require("misc.keybindings.global")

-- Load Misc
require("misc.platform")
