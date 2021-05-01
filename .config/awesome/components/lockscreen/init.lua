local awful = require("awful")
local gfs = require('gears.filesystem')

local lock_screen = {}

package.cpath = package.cpath .. ";" .. "/home/david/.config/awesome/components/lockscreen/?.so;"

lock_screen.init = function()
    local pam = require("liblua_pam")
    lock_screen.authenticate = function(password)
        return pam.auth_current_user(password)
    end
    require("components.lockscreen.lockscreen")
end

return lock_screen
