local Gtk = require("lgi").Gtk
local Gio = require("lgi").Gio
local M = {}

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

function M.tooltip(v, on_show, placement_fn)

  local text = wibox.widget.textbox()
  -- eh
  -- need to find a better solution
  placement_fn = placement_fn or function(c)  awful.placement.bottom_left(c, { honor_workarea = true, margins = { left = dpi(10), bottom = dpi(6) } }) end
  local popup = awful.popup {
	ontop = true,
	type = 'tooltip',
	bg = '#00000000',
	widget = {
	  layout = wibox.layout.fixed.horizontal,
	  {
		{
		  {
			text,
			widget = wibox.container.margin,
			margins = dpi(6)
		  },
		  widget = wibox.container.background,
		  bg = '#f0f0f0',
		  shape = gears.shape.rectangle,
		  shape_border_width = dpi(3),
		  shape_border_color = '#181818'
		},
		{
		  {
			widget = wibox.widget.separator,
			color='#181818',
			orientation = 'horizontal',
			thickness = 8,
			forced_width = dpi(1),
			forced_height = dpi(6),
			border_width = 0
		  },
		  widget = wibox.container.margin,
		  left = dpi(4)
		},
		layout = wibox.layout.fixed.vertical
	  },
	  {
		{
		  widget = wibox.widget.separator,
		  color='#181818',
		  orientation = 'vertical',
		  thickness = 8,
		  forced_width = dpi(6),
		  forced_height = dpi(1),
		  border_width = 0
		},
		widget = wibox.container.margin,
		top = dpi(4)
	  }
	},
	placement = placement_fn,
	visible = false
  }

  v:connect_signal("mouse::enter", function()
	text.markup = on_show()
	popup.visible = true
  end)

  v:connect_signal("mouse::leave", function()
	popup.visible = false
  end)

end

-- Popup that exits once you click somewhere else
function M.only_popup(popup, e)
  e = e or true
  if not e then
	return
  end
  popup.visible = true
  popup:connect_signal("mouse::leave", function()
	if mousegrabber.isrunning() then
	  mousegrabber.stop()
	end
	mousegrabber.run(function(m)
	  if (m.buttons[mouse.LEFT] == true or m.buttons[mouse.RIGHT] == true) then
		if mouse.current_wibox and mouse.current_wibox == popup then
		  return false
		else
		  popup.visible = false
		  return false
		end
	  end
	  return true
	end, "left_ptr")
  end)
  popup:connect_signal("mouse::enter", function()
	if mousegrabber.isrunning() then
	  mousegrabber.stop()
	end
  end)
end

-- Requirement {{{
local function update_dpi(self, ctx)
    if not self._private.handle then return end

    local dpi = self._private.auto_dpi and
        ctx.dpi or
        self._private.dpi or
        nil

    local need_dpi = dpi and
        self._private.last_dpi ~= dpi

    local need_style = self._private.handle.set_stylesheet and
        self._private.stylesheet

    local old_size = self._private.default and self._private.default.width

    if dpi and dpi ~= self._private.cache.dpi then
        if type(dpi) == "table" then
            self._private.handle:set_dpi_x_y(dpi.x, dpi.y)
        else
            self._private.handle:set_dpi(dpi)
        end
    end

    if need_style and self._private.cache.stylesheet ~= self._private.stylesheet then
        self._private.handle:set_stylesheet(self._private.stylesheet)
    end

    -- Reload the size.
    if need_dpi or (need_style and self._private.stylesheet ~= self._private.last_stylesheet) then
        set_handle(self, self._private.handle, self._private.cache)
    end

    self._private.last_dpi = dpi
    self._private.cache.dpi = dpi
    self._private.last_stylesheet = self._private.stylesheet
    self._private.cache.stylesheet = self._private.stylesheet

    -- This can happen in the constructor when `dpi` is set after `image`.
    if old_size and old_size ~= self._private.default.width then
        self:emit_signal("widget::redraw_needed")
        self:emit_signal("widget::layout_changed")
    end
end
-- }}}


  
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
