local json = require('platform.libs.json') -- JSON Library

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
	-- print(require('platform.libs.inspect')(tabData))
	local w = wibox.widget({
		{
			widget = wibox.container.background,
			forced_width = dpi(10),
			forced_height = dpi(10),
		},
		bg = tabData.active == true and '#181818' or '#00000000',
		widget = wibox.container.background,
		shape_border_width = 1,
		shape_border_color = '#181818',
		shape = gears.shape.circle,
		tabId = tabData.id, -- special snowflake wont become an id
		buttons = gears.table.join(
			awful.button({}, mouse.LEFT, function()
				focusTab(tabData.id)
			end),
			awful.button({}, mouse.RIGHT, function()
				removeTab(tabData.id)
			end)
		),
	})
	awful.tooltip({
		objects = { w },
		text = tabData.title or '',
	})
	return w
end

-- Setup
local export = {}
function export.attach(c)
	-- Ignore windows that arent firefox!
	-- if c.class ~= "Firefox" or c.class ~= "Firefox-esr" then
	--   	return nil
	--   end

	-- Container
	local list = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		spacing = dpi(5),
	})

	-- Setup Connections
	awesome.connect_signal('custom::update_ff_focused', function(id)
		for _, child in ipairs(list.children) do
			-- Focused tab was changed
			if child.tabId == id then
				child.bg = '#181818'
			else
				child.bg = '#00000000'
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
	awesome.connect_signal('custom::update_ff_tabs', function(out)
		local firefoxTabs = json.decode(out)
		list:reset()

		for _, tab in ipairs(firefoxTabs) do
			list:add(createItem(tab))
		end
	end)

	-- Remove Specific Tab
	awesome.connect_signal('custom::remove_ff_tab', function(id)
		for idx, tab in ipairs(list.children) do
			if id == tab.tabId then
				list:remove(idx)
				return
			end
		end
	end)

	-- New Tab
	awesome.connect_signal('custom::add_ff_tab', function(payload)
		local tab = json.decode(payload)
		list:add(createItem(tab))
	end)

	-- Update Tab Icon / URL / Etc
	awesome.connect_signal('custom::update_ff_tab', function(payload)
		local tab = json.decode(payload)

		for idx, child in ipairs(list.children) do
			if tab.id == child.tabId then
				list:set(idx, createItem(tab))
				child = nil
				-- Otherwise, if it was the active tab
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
  [TODO] Listen to events of tabs moving around
  
--]]

return export
