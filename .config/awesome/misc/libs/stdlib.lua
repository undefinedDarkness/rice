local Gtk = require("lgi").Gtk
local Gio = require("lgi").Gio
local M = {}

-- This is so very cursed ;-;
M.shadow_box = {}
function M.shadow_box.new(widget, size, offset,bg)
  return wibox.widget {
	  layout = wibox.layout.fixed.horizontal,
	  {
		-- Main Content
		{
		  {
			widget,
			widget = wibox.container.margin,
			margins = dpi(6)
		  },
		  widget = wibox.container.background,
		  shape = gears.shape.rectangle,
		  shape_border_width = dpi(3),
		  bg = bg,
		  shape_border_color = beautiful.bg_shadow
		},
		-- Bottom Horizontal Separator
		{
		  {
			widget = wibox.widget.separator,
			color = beautiful.bg_shadow,
			orientation = 'horizontal',
			id = 'b_h_sep',
			thickness = 8,
			forced_width = dpi(1),
			forced_height = dpi(size or 6),
			border_width = 0
		  },
		  widget = wibox.container.margin,
		  left = dpi(offset or 4),
		},
		layout = wibox.layout.fixed.vertical
	  },
	  {
		-- Right Vertical Separator
		{
		  widget = wibox.widget.separator,
			color = beautiful.bg_shadow,
		  orientation = 'vertical',
		  thickness = 8,
		  id = 'r_v_sep',
		  forced_width = dpi(size or 6),
		  forced_height = dpi(1),
		  border_width = 0
		},
		widget = wibox.container.margin,
		top = dpi(offset or 4),
	  }
	}
end

function M.shadow_box.toggle(w)
  local a = w:get_children_by_id('b_h_sep')[1]
  a.color = a.color == beautiful.bg_shadow and '#00000000' or beautiful.bg_shadow

  local b = w:get_children_by_id('r_v_sep')[1]
  b.color = b.color == beautiful.bg_shadow and '#00000000' or beautiful.bg_shadow
end


function M.gtk_lookup_icon(icon_name, size)
  local theme = Gtk.IconTheme.get_default()
  return theme:lookup_icon(icon_name, size or 24, {})
end

-- Table Manipulation

function M.contains(_table, value)
  for _, item in ipairs(_table) do
	if value == item then
	  return true
	end
  end
  return false
end

-- Text & Color

M.color = require('misc.libs.bling.helpers.color')
function M.color.colorify(color, txt)
  return '<span color="' .. (color or "#ff0000") .. '">' .. txt .. "</span>"
end

function M.color.rgba(r, g, b, a)
  return string.format("#%02x%02x%02x%x", r, g, b, math.ceil(a * 255))
end

function M.title_case(phrase)
  local result = string.gsub(phrase, "(%a)([%w_']*)", function(first, rest)
	return first:upper() .. rest:lower()
  end)
  return result
end

-- Layout

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

function M.contain_image(i, w, h, opt)
  return wibox.widget({
	gears.table.crush({
	  resize = true,
	  widget = wibox.widget.imagebox,
	  image = i,
	}, opt or {}),
	widget = wibox.container.constraint,
	width = w or 200,
	height = h or w or 200,
  })
end

local cairo = require('lgi').cairo
function M.color.monochrome_image(image)
  local surface = require('gears').surface.duplicate_surface(image)
  local cr = cairo.Context.create(surface)
  local patt = cairo.Pattern.create_for_surface(surface)
  cr:set_source_rgb(0, 0, 0)
  cr:set_operator(cairo.Operator.HSL_SATURATION)
  cr:mask(patt)
  return surface
end

-- Misc


-- Popup that exits once you click somewhere else
function M.only_popup(popup, e)
  e = e or true
  if not e then
	return
  end
  popup.visible = true

  local keygrab = awful.keygrabber {
	stop_key = 'Escape',
	stop_event = 'press',
	stop_callback = function()
	  popup.visible = false
	  if mousegrabber.isrunning() then
		mousegrabber.stop()
		end
	end
  }
  keygrab:start()

  popup:connect_signal("mouse::leave", function()
	if mousegrabber.isrunning() then
	  mousegrabber.stop()
	end

	mousegrabber.run(function(m)

	  if mouse.current_wibox and mouse.current_wibox == popup then
		return false
		end

	  if (m.buttons[1] or m.buttons[3]) and mouse.current_wibox ~= popup then
		  popup.visible = false
		  keygrab:stop()
		  return false
		end
		return true
	end, 'left_ptr')
  end)

  popup:connect_signal("mouse::enter", function()
	if mousegrabber.isrunning() then
	  mousegrabber.stop()
	end
  end)
end



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

function M.rounded(r)
  r = r or 8
  return function(cr, w, h)
	gears.shape.rounded_rect(cr, w, h, r)
  end
end

return M
