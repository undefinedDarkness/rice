local json = require("misc.libs.json") -- JSON Library

-- Write command to file; then send signal to python script
local function focusTab(id)
	awful.spawn.with_shell('echo "focusTab ' .. id .. '" >> /tmp/ff-tabs-input; kill -s SIGUSR1 $(pgrep server.py)')
end

local function removeTab(id)
	awful.spawn.with_shell('echo "removeTab ' .. id .. '" >> /tmp/ff-tabs-input; kill -s SIGUSR1 $(pgrep server.py)')
end

local function forceUpdate()
	awful.spawn.with_shell('echo "fullUpdate" >> /tmp/ff-tabs-input; kill -s SIGUSR1 $(pgrep server.py)')
end

local function createItem(tabData)
  print(require('misc.libs.inspect')(tabData))
  local w = wibox.widget {
	{
	  widget = wibox.container.background,
	  forced_width = dpi(10),
	  forced_height = dpi(10)
	},
	bg = tab.active and '#181818' or '#00000000',
	widget = wibox.container.background,
	shape_border_width = 1,
	shape_border_color = '#181818',
	shape = gears.shape.circle,
	id = tabData.id,
	buttons = gears.table.join({
	  awful.button({}, mouse.LEFT, function()
		focusTab(tabData.id)
	  end),
	  awful.button({}, mouse.RIGHT, function()
		removeTab(tabData.id)
	  end)
	}),
  }
  awful.tooltip {
	objects = { w },
	text = w.title or ""
  }
end


-- Setup
local export = {}
function export.x(c)
	-- Ignore windows that arent firefox!
	if c.class ~= "Firefox" then
		return nil
	end

	-- Container
	local list = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		spacing = dpi(5),
	})

	-- Setup Connections
	awesome.connect_signal("custom::update_ff_focused", function(id)
		for _, child in ipairs(list.children) do
			-- Focused tab was changed
			if child.id == id then
				child.bg = '#00000000'
			else
				child.bg = '#181818'
			end
		end
	end)

	-- Attempt to re-connect with firefox (mostly for awm restarts!)
	gears.timer({
		timeout = 5,
		autostart = true,
		single_shot = true,
		callback = function()
			if #list.children == 0 then
				forceUpdate()
			end
		end,
	})

	-- Full Update
	awesome.connect_signal("custom::update_ff_tabs", function(out)
	  local firefoxTabs = json.decode(out)
	  list:reset()

		for _, tab in ipairs(firefoxTabs) do
			list:add(getIcon(tab))
		end
	end)

	-- Remove Specific Tab
	awesome.connect_signal("custom::remove_ff_tab", function(id)
		for idx, tab in ipairs(list.children) do
			local x = tab:get_children_by_id("background_")[1]
			if x.tabId == id then
				list:remove(idx)
			end
		end
	end)

	-- New Tab
	awesome.connect_signal("custom::add_ff_tab", function(payload)
		local tab = json.decode(payload)
		list:add(createItem(tab))
	end)

	-- Update Tab Icon / URL / Etc
	awesome.connect_signal("custom::update_ff_tab", function(payload)
		local tab = json.decode(payload)

		for idx, child in ipairs(list.children) do
			-- Check if this tab was updated
			if tab.id == child.id then
				list:set(idx, createItem(tab))

			-- if the focused tab was changed, revert the other tabs. 
			elseif tab.active then
				child.bg = '#00000000'
			end
		end
	end)

	return list
end

--[[

Add ff-tabs-indicator widget when firefox is active and when it isnt remove it!
  [TODO] Add support for running multiple instances of firefox!
  [TODO] Make code more flexible 
  
--]]

return export
