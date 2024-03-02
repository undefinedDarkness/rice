local layout_no = wibox.widget.textbox()
layout_no.text = 0 -- s.selected_tag.index
layout_no.valign = 'center'
layout_no.align = 'left'
layout_no.font = 'Ostrich Sans Black 50'
layout_no:buttons(awful.button({}, mouse.LEFT, function()
	awful.tag.viewnext(mouse.screen)
end))

awful.screen.focused():connect_signal('tag::history::update', function()
	layout_no.markup = ' ' .. s.selected_tag.name
end)

return layout_no
