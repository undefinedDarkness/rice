-- Rules
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = require('platform.keybindings.client'),
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},

	-- Add titlebars to normal clients and dialogs
	{
		rule_any = {
			type = { 'normal', 'dialog' },
		},
		properties = { titlebars_enabled = true },
	},

	-- 🤮 Disable Titlebars For CSD Apps
	{
		rule = {
			requests_no_titlebar = true,
		},
		properties = { titlebars_enabled = false },
	},

	{
		rule = {
			type = 'utility',
		},
		properties = { sticky = true, special = true },
	},

	{
		rule = {
			name = "Picture-in-Picture"
		},
		properties = {
			ontop = true
		}
	},

	{
		rule = {
			name = 'Notion Dashboard'
		},
		properties = {
			special = true,
			sticky = true,
			placement = awful.placement.centered
		}
	}
}
