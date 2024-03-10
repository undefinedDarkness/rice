local std = require('platform.stdlib')
local bling_tagpreview = bling.widget.tag_preview

local tag_dashboard = wibox.widget({
	spacing = 16,
	layout = wibox.layout.fixed.vertical,
})

local tag_dashboard_ani_wrapper = wibox.widget({
	width = 300,
	tag_dashboard,
	widget = wibox.container.constraint,
})

local dashboard_fold = false

-- }
local update_before_display = function(display)
	if not display then
		return
	end

	tag_dashboard:reset()

	for _, tag in ipairs(root.tags()) do
		local scale = 0.18
		local margin = 2

		local filter_for_tag = function(client, s)
			return std.contains(client:tags(), tag)
		end

		local geo = tag.screen:get_bounding_geometry({
			honor_padding = true,
			honor_workarea = true,
		})

		local max_w = scale * geo.width + margin * 2
		local max_h = scale * geo.height + margin * 2

		tag_dashboard:add({
			{

				std.add_buttons(
					std.pointer(
						bling_tagpreview.draw_widget(
							tag,
							nil,
							nil,
							true,
							scale,
							8,
							8,
							1,
							'#fdbc87',
							'red',
							0,
							'transparent',
							beautiful.wibar_fg,
							0,
							geo,
							margin,
							wibox.widget({
								{
									widget = wibox.widget.imagebox,
									image = mouse.screen.mywall,
									halign = 'center',
									valign = 'center',
								},
								widget = wibox.container.background,
								bg = beautiful.wibar_bg,
							})
						)
					),
					{ awful.button({}, mouse.LEFT, function()
						awful.tag.viewonly(tag)
					end) }
				),
				widget = wibox.container.constraint,
				width = max_w,
				height = max_h,
			},

			awful.widget.tasklist({
				screen = mouse.screen,
				filter = filter_for_tag,
				layout = {
					layout = wibox.layout.fixed.vertical,
					spacing = 20,
				},
				widget_template = {
					{
						widget = wibox.widget.imagebox,
						id = 'icon_role',
					},
					widget = wibox.container.constraint,
					width = 24,
					height = 24,
				},
			}),
			spacing = 16,
			layout = wibox.layout.fixed.horizontal,
		})
	end
end

bling_tagpreview.enable({
	show_client_content = true,
})

local fold_btn = wibox.widget({
	widget = wibox.widget.textbox,
	text = '󰍜 ',
	font = beautiful.font .. ' 32',
	valign = 'top',
	buttons = {
		awful.button({}, mouse.LEFT, function()
			dashboard_fold = not dashboard_fold
			local timer = require('platform.libs.rubato').timed({
				duration = 2,
				awestore_compat = true,
				subscribed = function(pos)
					tag_dashboard.forced_width = 450 * (dashboard_fold and 1 - pos or pos)
				end,
			})
			timer.target = 1
		end),
	},
})
require('components.dashboard').register({
	widget = {
		widget = wibox.container.background,
		{
			{
				-- fold_btn,
				tag_dashboard,
				layout = wibox.layout.fixed.horizontal,
			},
			widget = wibox.container.margin,
			left = 20,
			right = 20,
			top = 10,
			bottom = 20,
		},
	},
	halign = 'left',
	valign = 'top',
	content_fill_vertical = true,
	update = update_before_display,
})
