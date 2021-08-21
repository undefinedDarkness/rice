-- Stolen & modified from java's dots which I think was further stolen from elenapan

update_interval = 30
local trackers = {
	require("misc.system.ram"),
	require("misc.system.cpu"),
	require("misc.system.temp"),
	require("misc.system.disk"),
	require("misc.system.battery"),
}

return {

	start = function()
		for _, tracker in ipairs(trackers) do
			tracker:start()
		end
	end,

	stop = function()
		for _, tracker in ipairs(trackers) do
			tracker:stop()
		end
	end,
}
