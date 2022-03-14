local naughty = require('naughty')
local C = require('misc.libs.stdlib')

if awesome.version == 'v4.3' then
	naughty.config.defaults.position = 'bottom_right'
	return
end
