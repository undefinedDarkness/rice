local GLib = require('lgi').GLib
local DateTime = GLib.DateTime
local home = os.getenv('HOME')

local dt = DateTime.new_now_local()

local function screenshot(cmd)
	-- local date = DateTime.format(dt, '%d-%m-%y-%T')
	local path = home .. '/Pictures/Screenshots/' .. GLib.uuid_string_random() .. '.png'
	awful.spawn.easy_async('maim -u ' .. cmd .. ' ' .. path, function(_, __, ___, e)
		if e == 0 then
			require('naughty').notify({
				title = 'Screenshot Taken',
				text = 'Taken on ' .. DateTime.format(dt, '%d/%m/%y'),
				icon = path,
			})
		end
	end)
end

return {
	screen = function()
		screenshot('')
	end,
	window = function()
		screenshot([[ -w $(xwininfo | grep -Eo -m1 '0x\S+' ) ]])
	end,
	selection = function()
		screenshot('-s')
	end,
}
