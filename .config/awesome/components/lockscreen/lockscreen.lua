-- This started off as a clone of Elenapan's lockscreen, but now it doesn't
-- look like it at all. Still, a special thanks to their dots!
-- https://github.com/elenapan/dotfiles/tree/master/config/awesome/elemental/lock_screen
--
-- Disclaimer:
-- THIS LOCKSCREEN IS NOT SECURE. PLEASE DON'T THINK THIS CAN STOP HACKERS. 
-- A SIMPLE AWESOMEWM RELOAD CAN BREAK THROUGH. I USE THIS BECAUSE I DONT CARE
-- ABOUT MY LAPTOP'S SECURITY.
--

local naughty = require("naughty")
local C = require("misc.custom")
local lock_screen = require("components.lockscreen")

local pass_textbox = wibox.widget.textbox()
local secret_textbox = wibox.widget {
    font = "Sarasa UI HC 12",
    widget = wibox.widget.textbox
}

-- FUNCTIONS

local function force_center_v(w)
    return wibox.widget {
        nil,
        w,
        nil,
        expand = "none",
        layout = wibox.layout.align.vertical
    }
end

local function set_visibility(v)
    for s in screen do s.mylockscreen.visible = v end
end

local function grab_password()
    awful.prompt.run {
        hooks = {
            -- Custom escape behaviour: Do not cancel input with Escape
            -- Instead, this will just clear any input received so far.
            {{}, 'Escape', function(_) grab_password() end}, -- Fix for Control+Delete crashing the keygrabber
            {{'Control'}, 'Delete', function() grab_password() end}
        },
        keypressed_callback = function(mod, key, cmd)
            -- Debug Stuff
            -- naughty.notify { title = 'Pressed', text = key }
        end,
        exe_callback = function(input)
            -- Check input
            if lock_screen.authenticate(input) then
                set_visibility(false)
            else
                secret_textbox.markup = C.colorify("#d4be9880", "<b><i>Password</i></b>")
                grab_password()
            end
        end,
        textbox = pass_textbox
    }
end

function lock_screen_show()
    set_visibility(true)
    grab_password()
end

-- END

pass_textbox:connect_signal("widget::redraw_needed", function()
    local secret = " "
    if #pass_textbox.text > 1 then
        for i = 1, #pass_textbox.text - 1, 1 do secret = secret .. "" end
        secret_textbox.markup = secret .. " "
    else
        secret_textbox.markup = C.colorify("#d4be9880", "<b><i>Password</i></b>")
    end
end)

-- Create the lock screen wibox
local lock_screen_box = wibox({
        visible = false,
        ontop = true,
        type = "splash",
        screen = screen.primary
    })
awful.placement.maximize(lock_screen_box)
lock_screen_box.bgimage = gears.surface(beautiful.lockscreen_wallpaper)

-- Add lockscreen to every screen (or only one :P)
awful.screen.connect_for_each_screen(function(s)
    s.mylockscreen = lock_screen_box
end)

-- Widgets

-- PFP / NAME / NICKNAME
local pfp = C.force_center {
        {
            image = beautiful.pfp,
            resize = true,
            clip_shape = gears.shape.circle,
            widget = wibox.widget.imagebox,
            forced_height = dpi(150),
            forced_width = dpi(150)
        },
        bg = '#000000',
        shape = gears.shape.circle,
        widget = wibox.container.background
    }
local name = C.force_center {
    text = "nes", -- CHANGE
    widget = wibox.widget.textbox,
    font = "Sarasa UI HC Bold 22"
}
local nickname = C.force_center {
    text = "@DarkNES#4901", -- CHANGE
    widget = wibox.widget.textbox,
    font = "Sarasa UI HC 16"
}

-- CLOCK
local clock = wibox.widget {
    font = "Sarasa UI HC Semibold 35",
    align = 'center',
    valign = 'center',
    format = '<b>%l:%M%P</b>',
    widget = wibox.widget.textclock
}

-- SHUTDOWN / RESTART / EXIT
local create_button = function(text, command)
    local icon = C.force_center(C.hover_effect({
        forced_height = dpi(35),
        align = "center",
        valign = "center",
        font = "Sarasa UI HC 10",
        markup = text,
        widget = wibox.widget.textbox()
    }, function(w, m) if m then w.font = "Sarasa UI HC Bold 10" else w.font = "Sarasa UI HC 10" end end))

    icon:buttons(awful.button({}, 1, function() command() end))
    return icon
end

local restart = create_button("Restart", function() awful.spawn("systemctl reboot") end)
local shutdown = create_button("Shutdown", function() awful.spawn("systemctl poweroff") end)
local display_manager = create_button("Exit", function() awesome.quit() end)

local highlight_txt = require("subcomponents.sidebar_bits").highlight_txt

-- MUSIC PLAYER IMAGE
local _playing = wibox.widget {
        widget = wibox.widget.textbox,
        --forced_width = 200,
        valign = "center",
        align = "center",
        --forced_height = 200,
        markup = C.colorify("#fafafa", playerctl_state._playing),
        font = "Arimo Nerd Font 50",
        id = "toggle_play",
        visible = false,
        buttons = awful.button({}, mouse.LEFT, function() awful.spawn("playerctl play-pause") end)
    }
local music_image_widget = wibox.widget {
    {
        {
            widget = wibox.widget.imagebox,
            resize = true,
            image = gears.surface.load_uncached(playerctl_state.image),
            clip_shape = function(cr, w, h)
                gears.shape
                    .rounded_rect(cr, w, h, 16)
            end,
            id = "image"
        },
        -- TODO: Tweak colors a bit
        _playing,
        layout = wibox.layout.stack
    },
    widget = wibox.container.constraint,
    height = 150,
    width = nil
}

music_image_widget:buttons(
    awful.button({}, mouse.MIDDLE, function()
        music_image_widget:get_children_by_id("image")[1]:set_image(gears.surface.load_uncached(user_home .. "/.config/awesome/theme/record.jpg"))
    end)
)

music_image_widget:connect_signal("mouse::enter", function()
    _playing.visible = true
end)

music_image_widget:connect_signal("mouse::leave", function()
    _playing.visible = false
end)

local music_title_tooltip = awful.tooltip {
    objects = {music_image_widget},
    text = playerctl_state.playing,
    bg = "#32302f",
    fg = "#d4be98",
    shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 3) end
}

awesome.connect_signal("bling::playerctl::title_artist_album",
function(title, artist, image)
    music_title_tooltip.text = title .. " ~ " .. artist
    music_image_widget:get_children_by_id("image")[1]:set_image(gears.surface.load_uncached(image))
end)

awesome.connect_signal("bling::playerctl::status", function(x)
    if x then
        _playing.markup = C.colorify("#fafafa", "")
    else
        _playing.markup = C.colorify("#fafafa", "契")
    end
end)


-- Item placement
lock_screen_box:setup {
    C.force_center(force_center_v{
        clock,
        {
            shutdown,
            restart,
            display_manager,
            spacing = dpi(25),
            layout = wibox.layout.fixed.horizontal
        },
        layout = wibox.layout.fixed.vertical
    }),
    C.force_center(force_center_v{
        pfp,
        name,
        nickname,
        C.force_center(secret_textbox),
        spacing = 15,
        layout = wibox.layout.fixed.vertical
    }),
    C.force_center(force_center_v{
        music_image_widget,
        {
            {
                    awful.widget.tasklist {
                    screen = awful.screen.focused(),
                    filter = awful.widget.tasklist.filter.alltags,
                    layout = {
                        spacing = 15,
                        layout = wibox.layout.fixed.horizontal
                    },
                    widget_template = {
                        widget = awful.widget.clienticon,
                        forced_height = 36,
                        forced_width = 36,
                        create_callback = function(self, c)
                            self.client = c
                        end
                    }
                },
                widget = wibox.container.margin,
                margins = 8
            },
            shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 8) end,
            widget = wibox.container.background,
            bg = "#fafafaCC"
        },
        spacing = 15,
        layout = wibox.layout.fixed.vertical
    }),
    layout = wibox.layout.flex.horizontal
}
