-- General Setup of awesomewm
-- Tags
-- Layouts
-- Error handling
-- Root / Client buttons
-- Rules
require('awful.autofocus')

-- Setup Window Layouts
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.floating,
	awful.layout.suit.spiral.dwindle,
}

-- Setup Tags
mouse.screen.mywall = gears.surface.load(beautiful.wallpaper)
awful.screen.connect_for_each_screen(function(s)
	local tags = awful.tag(beautiful.workspaces, s, awful.layout.layouts[1])
	gears.wallpaper.maximized(mouse.screen.mywall, s, '#f0f0f0')
	awesome.emit_signal('custom::tags_inited', tags)
end)

-- Errors {{{
local naughty = require('naughty')
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = 'Oops, there were errors during startup!',
		text = awesome.startup_errors,
	})
end

local in_error = false
awesome.connect_signal('debug::error', function(err)
	-- Make sure we don't go into an endless error loop
	if in_error then
		return
	end
	in_error = true

	naughty.notify({
		preset = naughty.config.presets.critical,
		title = 'Oops, an error happened!',
		text = tostring(err),
	})
	in_error = false
end)

-- }}}

-- Root Window Buttons {{{
root.buttons(gears.table.join(
	awful.button({}, mouse.RIGHT, function()
		require('subcomponents.menu').root_menu()
	end),
	awful.button({}, mouse.SCROLL_UP, awful.tag.viewnext),
	awful.button({}, mouse.SCROLL_DOWN, awful.tag.viewprev)
))

-- }}}

-- Client Buttons {{{
clientbuttons = gears.table.join(
	awful.button({}, mouse.LEFT, function(c)
		c:emit_signal('request::activate', 'mouse_click', { raise = true })
	end),
	awful.button({ modkey }, mouse.LEFT, function(c)
		c:emit_signal('request::activate', 'mouse_click', { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, mouse.RIGHT, function(c)
		c:emit_signal('request::activate', 'mouse_click', { raise = true })
		awful.mouse.client.resize(c)
	end)
)
-- }}}

-- Signals {{{
local lookup_icon = require('menubar.utils').lookup_icon
client.connect_signal('manage', function(c)
	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		(awful.placement.no_overlap + awful.placement.no_offscreen)(c) --offscreen(c)
	end
end)

-- client.connect_signal("mouse::enter", function(c)
--     c:emit_signal("request::activate", "mouse_enter", {raise = false})
-- end)

require('subcomponents.rules')
