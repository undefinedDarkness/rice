local json = require("misc.libs.json") -- JSON Library

-- Write command to file; then send signal to python script
local function focusTab(id)
	awful.spawn.with_shell('echo "focusTab ' .. id .. '" >> /tmp/ff-tabs-input; kill -s SIGUSR1 $(pgrep server.py)')
end

local function removeTab(id)
	awful.spawn.with_shell('echo "removeTab ' .. id .. '" >> /tmp/ff-tabs-input; kill -s SIGUSR1 $(pgrep server.py)')
end

local function setFavicon(widget, url)
	local image_widget = widget:get_children_by_id("icon")[1]
	local bg_widget = widget:get_children_by_id("background_")[1]

	-- If is base64 encoded image file
	if string.find(url or "", "data:image/%S+base64,") then
		local path = os.tmpname()
		local image = url:gsub("data:image/%S+;base64,", "")
		awful.spawn.easy_async_with_shell("echo '" .. image .. "' | base64 -d >> " .. path, function(_, err)
			if err then print(err) end
			image_widget.image = path
			bg_widget.iconPath = path
            bg_widget.iconId = image:sub(0, 25)
		end)
	else
		image_widget.image = _config_dir .. "theme/assets/site.svg"
	end
end

local function getIcon(tab)
	local iconWidget = wibox.widget({
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
				widget = wibox.container.margin,
				margins = dpi(5),
			},
			widget = wibox.container.background,
			bg = tab.active and "#373b41" or "#00000000",
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
			tabId = tab.id
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
	local list = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		spacing = dpi(5),
	})

	-- Setup Connections
	awesome.connect_signal("custom::update_ff_focused", function(id)
		for _, child in ipairs(list.children) do
			local x = child:get_children_by_id("background_")[1]
			if x.tabId == id then
				x.bg = "#373b41"
			else
				x.bg = "#00000000"
			end
		end
	end)
    -- TODO: Might remove entirely
	awesome.connect_signal("custom::update_ff_tabs", function(out)
		local firefoxTabs = json.decode(out)
		list:reset()
		for _, tab in ipairs(firefoxTabs) do
			list:add(getIcon(tab))
		end
	end)
	awesome.connect_signal("custom::remove_ff_tab", function(id)
		for idx, tab in ipairs(list.children) do
			local x = tab:get_children_by_id("background_")[1]
			if x.tabId == id then
				if x.tabIconPath then awful.spawn("rm " .. x.tabIconPath) end -- Clean up icon file if it exists
				list:remove(idx)
			end
		end
	end)
	awesome.connect_signal("custom::add_ff_tab", function(payload)
		local tab = json.decode(payload)
		list:add(getIcon(tab))
	end)
	awesome.connect_signal("custom::update_ff_tab", function(payload)
		local tab = json.decode(payload)
        
        local iconId = (tab.favIconUrl or ""):gsub("data:image/%S+;base64,", "")
        iconId = string.sub(iconId, 0, 25)

		for idx, child in ipairs(list.children) do
			local x = child:get_children_by_id("background_")[1]
            -- Check if tab id matches and then check if icon has been changed, if not ignore!
			if x.tabId == tab.id then
                if x.iconId ~= iconId then
                    if x.iconPath then awful.spawn("rm "..x.iconPath) end
                    list:set(idx, getIcon(tab))
                end
            -- if tab is focused, everything else reverts!
            elseif tab.active then
                x.bg =  "#00000000"
            end
        end
	end)

	return wibox.widget({
		{
			list,
			widget = wibox.container.margin,
			top = dpi(5),
            left = dpi(5),
			right = dpi(5),
			bottom = dpi(5),
			draw_empty = false,
		},
		widget = wibox.container.background,
		bg = "#282a2e"
	})
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
