return function(volume)
	local sign = "+"
	if volume < 0 then
		sign = "-"
		volume = volume * -1
	end
	awful.spawn("amixer sset 'Master' " .. tostring(volume) .. "%" .. sign)
end
