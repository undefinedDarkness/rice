local M = {}

-- Table Manipulation {{{

function M.contains(_table, _c)
	for _, c in ipairs(_table) do
		if _c == c then
			return true
		end
	end
	return false
end

-- }}}
-- Text & Color {{{

function M.colorify(color, txt)
	return '<span color="' .. color .. '">' .. txt .. "</span>"
end

function M.rgba(r, g, b, a)
	return string.format("#%02x%02x%02x%x", r, g, b, math.ceil(a * 255))
end

function M.trim_long(x, max_len)
	max_len = max_len or 25
	if string.len(x) > max_len then
		return string.sub(x, 0, max_len)
	else
		return x
	end
end

-- }}}
-- Layout {{{

function M.force_left(x)
	return wibox.widget({
		x,
		widget = wibox.container.place,
		halign = "left",
	})
end

function M.force_center(x)
	return wibox.widget({
		x,
		widget = wibox.container.place,
		halign = "center",
		valign = "center",
	})
end

function M.force_right(x)
	return wibox.widget({
		x,
		widget = wibox.container.place,
		halign = "right",
	})
end

function M.contain_image(i, s)
	return wibox.widget({
		{
			widget = wibox.widget.imagebox,
			image = i,
		},
		widget = wibox.container.constraint,
		width = s,
		height = s,
	})
end

-- }}}
-- Misc {{{

-- Courtesy of no37
function M.hexagon_shape(cr, width, height)
	temp = 0
	if width > height then
		temp = height
	else
		temp = width
	end
	cr:move_to(temp / 2, 0)
	cr:line_to(temp, temp * 3 / 11)
	cr:line_to(temp, temp * 8 / 11)
	cr:line_to(temp / 2, temp)
	cr:line_to(0, temp * 8 / 11)
	cr:line_to(0, temp * 3 / 11)
	cr:close_path()
end

function M.hover_effect(w, exe)
	if w["connect_signal"] == nil then
		w = wibox.widget(w)
	end

	w:connect_signal("mouse::enter", function()
		exe(w, true)
	end)
	w:connect_signal("mouse::leave", function()
		exe(w, false)
	end)

	return w
end

function M.rounded(r)
	r = r or 8
	return function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, r)
	end
end

-- }}}
return M
