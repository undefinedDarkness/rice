local x = {}

local function remove_last()
	awful.spawn.with_shell(
		[[ rm $HOME/Pictures/Screenshots/$(ls -Ft $HOME/Pictures/Screenshots | grep -Ev '@|/' | tail -1) ]]
	)
end

-- stolen from https://github.com/Donearm/scripts/blob/master/lib/basename.lua
local function basename(str)
	local name = string.gsub(str, "(.*/)(.*)", "%2")
	return name
end

local function notify(filepath)
	require("naughty").notification({
		image = filepath,
		title = "Screenshot taken",
		text = basename(filepath),
	})
end

local function get_filepath()
	return user_home .. "/Pictures/Screenshots/" .. os.time(os.date("*t")) .. ".png"
end

function x.selection()
	local filepath = get_filepath()
	awful.spawn.easy_async_with_shell([[slop=$(slop -f "%g") || exit 1
        read -r G < <(echo $slop)
        import -window root -crop $G  ]] .. filepath, function(_, _, _, exit_code)
		if exit_code == 0 then
			notify(filepath)
			remove_last()
		end
	end)
end

function x.root()
	local filepath = get_filepath()
	awful.spawn.easy_async("import -window root " .. filepath, function()
		require("naughty").notification({
			image = filepath,
			title = "Screenshot taken",
			text = filepath,
		})
		remove_last()
	end)
end

function x.win()
	local filepath = get_filepath()
	awful.spawn.easy_async_with_shell([[import -window $(xwininfo | grep -Po '0x\d{6}' -m1)]] .. filepath, function()
		require("naughty").notification({
			image = filepath,
			title = "Screenshot taken",
			text = filepath,
		})
		remove_last()
	end)
end

return x
