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

local function trimLong(t, m)
	m = m or 20
	if #t > m then
		return t:sub(0, m)
	else
		return t
	end
end

local function fullClean(list)
	for _, tab in ipairs(list.children) do
		local x = tab:get_children_by_id("background_")[1].iconPath
		if x then
			awful.spawn("rm " .. x)
		end
	end
end

local function setFavicon(widget, url)
	local image_widget = widget:get_children_by_id("icon")[1]
	local bg_widget = widget:get_children_by_id("background_")[1]

	-- If is base64 encoded image file
	if string.find(url or "", "data:image/%S+base64,") then
		local path = os.tmpname()
		local image = url:gsub("data:image/%S+;base64,", "")
		awful.spawn.easy_async_with_shell("echo '" .. image .. "' | base64 -d >> " .. path, function(_, err)
			image_widget.image = path
			bg_widget.iconPath = path
			bg_widget.iconId = image:sub(0, 25)
			if string.len(err) > 0 then
				print("ERROR:", err)
			end
		end)
	else
		image_widget.image = _config_dir .. "theme/assets/site.svg"
	end
end

local focusBG = "#c5c8c6"
local focusFG = "#1d1f21"
-- local unFocusFG = "#e0e0e0"
--local unFocusBG = "#00000000"
local function getIcon(tab)
	local iconWidget = wibox.widget({
		{
			{
				{
					{
						{
							{
								widget = wibox.widget.imagebox,
								scaling_quality = "best",
								id = "icon",
							},
							widget = wibox.container.constraint,
							width = dpi(20),
							height = dpi(20),
						},
						widget = wibox.container.place,
						halign = "center",
						valign = "center",
					},
					{
						{
							widget = wibox.widget.textbox,
							text = trimLong(tab.title or ""),
							font = "PT Sans",
							valign = "center",
							visible = tab.active or false, -- If active show, otherwise dont
							id = "title",
						},
						widget = wibox.container.margin,
						left = dpi(5),
					},
					layout = wibox.layout.fixed.horizontal,
				},
				widget = wibox.container.margin,
				top = dpi(5),
				left = dpi(8),
				right = dpi(8),
				bottom = dpi(5),
			},
			widget = wibox.container.background,
			bg = tab.active and focusBG or "#00000000",
			active = tab.active,
			shape = function(cr, w, h)
				gears.shape.rounded_rect(cr, w, h, 5)
			end,
			buttons = gears.table.join(
				awful.button({}, mouse.LEFT, function()
					focusTab(tab.id)
				end),
				awful.button({}, mouse.RIGHT, function()
					removeTab(tab.id)
				end)
			),
			id = "background_",
			tabId = tab.id,
			fg = focusFG,
		},
		widget = wibox.container.place,
		halign = "center",
		valign = "center",
	})
	setFavicon(iconWidget, tab.favIconUrl)
	return iconWidget
end

-- Setup
local export = {}
function export.x(c)
	-- Ignore windows that arent firefox!
	if c.class ~= "Firefox-esr" then
		return nil
	end

	if client.focus ~= c then
		print("Client isnt focused!")
		focusBG = "#282a2e"
		focusFG = "#e0e0e0"
	end

	-- Container
	local list = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		spacing = dpi(5),
	})

	-- Setup Connections
	awesome.connect_signal("custom::update_ff_focused", function(id)
		for _, child in ipairs(list.children) do
			local x = child:get_children_by_id("background_")[1]
			if x.tabId == id then -- if is the selected tab
				x.bg = focusBG
				child:get_children_by_id("title")[1].visible = true
				x.active = true
			else
				child:get_children_by_id("title")[1].visible = false
				x.bg = unFocusBG
				x.active = false
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

		-- Might not be needed, since this is usually run at the start and the list is empty
		fullClean(list)

		list:reset()
		for _, tab in ipairs(firefoxTabs) do
			list:add(getIcon(tab))
		end
	end)

	-- Before Exit / Restart
	awesome.connect_signal("exit", function()
		fullClean(list)
	end)

	-- Remove Specific Tab
	awesome.connect_signal("custom::remove_ff_tab", function(id)
		for idx, tab in ipairs(list.children) do
			local x = tab:get_children_by_id("background_")[1]
			if x.tabId == id then
				if x.iconPath then
					awful.spawn("rm " .. x.iconPath)
				end
				list:remove(idx)
			end
		end
	end)

	-- New Tab
	awesome.connect_signal("custom::add_ff_tab", function(payload)
		local tab = json.decode(payload)
		list:add(getIcon(tab))
	end)

	-- Update Tab Icon / URL / Etc
	awesome.connect_signal("custom::update_ff_tab", function(payload)
		local tab = json.decode(payload)

		iconId = nil
		if string.find(tab.favIconUrl, "data:image/%S+base64,") then
			iconId = (tab.favIconUrl or ""):gsub("data:image/%S+;base64,", "")
			iconId = string.sub(iconId, 0, 25)
		end

		for idx, child in ipairs(list.children) do
			local x = child:get_children_by_id("background_")[1]
			-- Check if tab id matches
			if x.tabId == tab.id then
				-- and then check if icon has been changed, if not ignore!
				if iconId and x.iconId ~= iconId then
					if x.iconPath then
						awful.spawn("rm " .. x.iconPath)
					end
					list:set(idx, getIcon(tab))
				end

				-- if tab is focused, everything else reverts!
			elseif tab.active then
				x.bg = unFocusBG
			end
		end
	end)

	local final = wibox.widget({
		{
			list,
			widget = wibox.container.margin,
			top = dpi(5),
			left = dpi(5),
			right = dpi(5),
			bottom = dpi(5),
		},
		widget = wibox.container.background,
		bg = "#00000000",
	})
	c:connect_signal("unfocus", function()
		focusBG = "#282a2e"
		focusFG = "#e0e0e0"
		for _, tab in ipairs(list.children) do
			local bg = tab:get_children_by_id("background_")[1]
			bg.fg = focusFG
			if bg.active == true then -- is tab focused?
				bg.bg = focusBG
			else
				bg.bg = "#00000000"
			end
		end
	end)
	c:connect_signal("focus", function()
		focusBG = "#c5c8c6"
		focusFG = "#1d1f21"
		for _, tab in ipairs(list.children) do
			local bg = tab:get_children_by_id("background_")[1]
			bg.fg = focusFG
			if bg.active == true then -- is tab focused?
				bg.bg = focusBG
			else
				bg.bg = "#00000000"
			end
		end
	end)
	return final
end

--[[

Add ff-tabs-indicator widget when firefox is active and when it isnt remove it!
TODO: Add support for running multiple instances of firefox!

--]]
function export.attach()
	local ll
	client.connect_signal("focus", function(c)
		if c.class == "Firefox-esr" then
			ll = ll or export.x(c)
			mouse.screen.left_mod:add(ll)
		end
	end)
	client.connect_signal("unfocus", function(c)
		if c.class == "Firefox-esr" then
			mouse.screen.left_mod:remove(#mouse.screen.left_mod.children)
		end
	end)
end

return export
