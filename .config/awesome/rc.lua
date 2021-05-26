pcall(require, "luarocks.loader")

-- Awesome WM Configuration --

-- 📚 Awesome Standard Library 
gears = require("gears")
awful = require("awful")
-- Widget and layout library
wibox = require("wibox")
-- Theme handling library
beautiful = require("beautiful")

-- 🎨 Load Theme
beautiful.init("~/.config/awesome/theme/theme.lua")

-- Bling Library
bling = require("bling")

-- DPI Function
dpi = require("beautiful.xresources").apply_dpi

require("awful.hotkeys_popup.keys")
require("awful.autofocus")

-- 🚀 Load Launch Script
awful.spawn.with_shell("~/Documents/Scripts/launch.sh")

-- 🔨 Variable definitions

terminal = "st"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

if terminal == "wezterm" then
	editor_cmd = "wezterm start " .. editor
end

modkey = "Mod4"
user_home = os.getenv("HOME")
local get_icon = require('menubar.utils').lookup_icon

-- For Convienience 
workspaces = { "", "", "", "", "V" }

mouse = {
    LEFT = 1,
    MIDDLE = 2,
    RIGHT= 3,
    SCROLL_UP = 4,
    SCROLL_DOWN = 5
}

_nerd_font = "Arimo Nerd Font 12"

-- Window Layouts
awful.layout.layouts = {    
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.spiral
}

-- Load Misc
require("misc.errors")

-- Load System Info Scripts
require("misc.system")

-- Load Components
require("components.menu")
require("components.titlebar")
require("components.bar")
require("components.hello_user")
require("components.sidebar")
require("components.notifications")

-- Load Global Keybindings
require("misc.keybindings.global")

-- {{{ Mouse bindings
root.buttons(gears.table.join(
        awful.button({ }, mouse.RIGHT, function () mymainmenu:toggle() end),
        awful.button({ }, mouse.SCROLL_UP, awful.tag.viewnext),
        awful.button({ }, mouse.SCROLL_DOWN, awful.tag.viewprev)
    ))
-- }}}



clientbuttons = gears.table.join(
    awful.button({ }, mouse.LEFT, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, mouse.LEFT, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, mouse.RIGHT, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
    )

-- Set keys
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
        properties = { border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = require("misc.keybindings.client"),
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },


    -- Floating clients.
    { rule_any = {
            instance = {
                "DTA",  -- Firefox addon DownThemAll.
                "copyq",  -- Includes session name in class.
                "pinentry",
            },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin",  -- kalarm.
                "Sxiv",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
            "xtightvncviewer"},

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester",  -- xev.
            },
            role = {
                "AlarmWindow",  -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
            }
    }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
        }, properties = { titlebars_enabled = true }
    },

    -- Disable Titlebars For CSD Apps ~ REEEEEE
    { rule_any = { class = {
        "Mixer",
        "File-roller",
        "Eog",
        "Gedit",
        "Gnome-calculator"
    } }, properties = { titlebars_enabled = false } },

}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

    -- Give icons to some apps that lack icons 
    if c.class == "St" or c.class == "st-256color" then
        local new_icon = gears.surface(get_icon("gnome-terminal"))
        c.icon = new_icon._native
    elseif c.class == "Discord" then
        local new_icon = gears.surface(get_icon("discord"))
        c.icon = new_icon._native
    elseif c.class == "Spotify" then
        local new_icon = gears.surface(get_icon("spotify"))
        c.icon = new_icon._native
    end

end)



-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
