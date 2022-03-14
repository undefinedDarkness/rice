local cl = require('misc.libs.stdlib') -- .color

local tasklist_buttons = gears.table.join(
  awful.button({}, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end)
)

return function(s)
  require('misc.libs.bling.widget.tabbed_misc.custom_tasklist').initiate()

  local function get_icon_for(c, box)
    local class = c.class:lower()
    local icons = { 'libresprite', 'xterm', 'emacs', 'firefox', 'thunar', 'colr', 'firefox-esr' } -- TODO: Get this list automatically
    for _, v in ipairs(icons) do
      if class == v then
        return gears.filesystem.get_configuration_dir() .. 'theme/assets/icons/' .. v .. '.png'
      end
    end
    return cl.color.monochrome_image(c.icon)
  end

  return awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    layout = { layout = wibox.layout.fixed.horizontal, spacing = dpi(8) },
    buttons = tasklist_buttons,
    widget_template = {
      {
        {
          {
            widget = require('misc.libs.backport.imagebox'),
            id = 'c_icon',
          },
          widget = wibox.container.margin,
          margins = dpi(4),
        },
        layout = wibox.layout.fixed.horizontal,
      },
      spacing = dpi(5),
      layout = wibox.layout.fixed.horizontal,
      create_callback = function(self, c, index, objects)
        local box = self:get_children_by_id('c_icon')[1]
        if c.minimized then
          box.image = gears.color.recolor_image(get_icon_for(c, box), '#555')
        else
          box.image = get_icon_for(c, box)
        end

        -- Firefox Tabs Support
        require('misc.libs.bling.widget.tabbed_misc.custom_tasklist').register(self, c)
        if c.class == 'Firefox' then
          self:add(require('misc.libs.firefox').attach(c))
        end

        -- Tooltip With Client Title
        awful.tooltip({
          objects = { self.children[1] },
          timer_function = function()
            local out = c.name
            if c.first_tag ~= mouse.screen.selected_tag then
              out = out .. ' (' .. (c.first_tag or { index = '?' }).index .. ')'
            end
            return out
          end,
          timeout = 60,
        })

        -- Onclick Events
        self.children[1]:buttons(awful.button({}, 1, function()
          if awful.screen.focused().selected_tag ~= c:tags()[1] then
            c.first_tag:emit_signal('request::select')
          end
          if client.focus == c then
            c.minimized = true
            box.image = gears.color.recolor_image(get_icon_for(c, box), '#555')
          else
            c:emit_signal('request::activate', 'tasklist', { raise = true })
            box.image = get_icon_for(c, box)
          end
        end))
      end,
    },
  })
end
