local groups = {}

local function report_bad_bind(bind)
  require('naughty').notify {
	text = "This bind is faulty: " .. require('misc.libs.inspect')(bind)
  }
end

groups.emacs = {
  {
	description = "Exit",
	mod = { "C", "x", "C" },
	key = "c"
  },
  {
	description = "Find File",
	mod = { "C", "x", "C" },
	key = "f"
  },
  {
	description = "Navigate Buffers",
	mod = { "C", "x" },
	key = "b"
  },
  {
	description = "Paste",
	mod = { "C" },
	key = "y"
  },
  {
	description = "Save File",
	mod = { "C", "x" },
	key = "s"
  },
  {
	description = "Command Palette",
	mod = { "Alt" },
	key = 's'
  }
}

for _, hotkey in ipairs(awful.key.hotkeys) do

  if not hotkey.group then
	report_bad_bind(hotkey)
	goto continue
  end

  hotkey.group = hotkey.group:lower()
  if not groups[hotkey.group] then
	groups[hotkey.group] = {}
  end
  table.insert(groups[hotkey.group], hotkey)
  ::continue::
end
-- TODO: Refactor some bits to not use globals
-- Flatten table containing tables of strings
function tbl_flat(tbl)
  local out = {}
  for _, tables in ipairs(tbl) do
	for _, _string in ipairs(tables) do
	  table.insert(out, _string)
	end
  end
  return out
end


local groups_sidebar = wibox.layout.fixed.horizontal()
local data = wibox.widget({
  layout = wibox.layout.grid.horizontal,
  fixed_num_cols = 2,
  vertical_spacing = dpi(1),
})


local last = "awesome"
function update_sidebar_selected(selected)
  groups[selected].title.widget.markup = "<b>" .. selected .. "</b>"
  groups[last].title.widget.markup =  last
  last = selected
end

for key, group in pairs(groups) do
  groups[key].title = wibox.widget({
	  {
		widget = wibox.widget.textbox,
		text =  key,
	  },
	widget = wibox.container.margin,
	margins = dpi(8),
	buttons = awful.button({}, mouse.LEFT, function()
	  update_data(key)
	  update_sidebar_selected(key)
	end)
	})
  
  groups_sidebar:add(groups[key].title)
end


function update_data(selected)
  data:reset()
  for idx, hotkeys in ipairs(groups[selected]) do
	data:insert_row()
	
	if hotkeys.mod[1] == 'Mod1' then
	  hotkeys.mod[1] = 'Alt'
	elseif hotkeys.mod[1] == 'Mod4' then
	  hotkeys.mod[1] = 'Super'
	end

	local c = idx ~= #groups[selected] and beautiful.fg_inactive or nil
	local key_str = '<b>' .. table.concat(hotkeys.mod, '</b> + <b>') .. '</b> + ' .. hotkeys.key
	if #hotkeys.mod == 0 then
	  key_str = hotkeys.key
	end

	
	data:add(wibox.widget {
	  widget = wibox.container.margin,
	  bottom = 8,
	  {
		widget = wibox.widget.textbox,
		markup = key_str
	  }
	})
	data:add(wibox.widget {
	  widget = wibox.container.margin,
	  bottom = 8,
	  {
		widget = wibox.widget.textbox,
		text = hotkeys.description or "NO DESCRIPTION"
	  }
	})
  end
end

-- Init
groups["awesome"].title.widget.markup = "<b>awesome</b>"
update_data('awesome')

local window = awful.popup({
  placement = awful.placement.centered,
  ontop = true,
  -- minimum_width= 400,
  widget = {
	{ {
	  groups_sidebar,
	  widget = wibox.container.place,
	  halign = 'center'
	},
	  widget = wibox.container.background,
	  bg = '#1f1f1f',
	  fg = beautiful.fg_grey
	},
	{
	  data,
	  widget = wibox.container.margin,
	  margins = dpi(20),
	  draw_empty = true,
	},
	layout = wibox.layout.fixed.vertical,
	buttons = awful.button({}, mouse.RIGHT, function(c)
	  c.visible = false
	end),
  },
  visible = false,
  bg = beautiful.bg_wall,
})

return function()
  require('misc.libs.stdlib').only_popup(window)
end
