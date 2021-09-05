local sign = {
	define = vim.fn.sign_define,
	unplace = vim.fn.sign_unplace,
	place = vim.fn.sign_place
}
local pos = {}
-- Defaults and Configuration Global
local options = {
	error = ">>",
	error_group = "ErrorMsg",
	warning = "--",
	warning_group = "WarningMsg",
	warning_types = { "w", "W" }
}  

-- Update Error Markers
function _G.errorMarkerUpdate()
	-- Remove old signs
	for _, v in ipairs(pos) do
		sign.unplace(v)	
	end
	pos = {}

	-- Loop over quick fix list
	for _, v in ipairs(vim.fn.getqflist()) do
		local id = tostring(v.bufnr) .. ":" .. tostring(v.lnum)
		if id ~= "0:0" or (not vim.tbl_contains(pos, id)) then
			pos[#pos + 1] = id -- Add to position state
			
			local name = "errorMarkerError"
			if #v.type > 0 and vim.tbl_contains(options.warning_types, v.type) then
				name = "errorMarkerWarning"
			end

			sign.place(id, "", name, v.bufnr, { lnum = v.lnum })
		end
	end
end

function _G.errorMarkerShowMessage()
	local bufnr = vim.fn.bufnr("%")
	local lnum = vim.fn.line(".")
	for _, v in ipairs(vim.fn.getqflist()) do
		if bufnr == v.bufnr and v.lnum == lnum then
			print(v.text)
			return
		else
			print(" ")
		end
	end
end

-- Main 
return function ()
	o = o or {}
	for k, v in pairs(options) do
		if o[k] then
			options[k] = v
		end
	end

	-- Setup Signs
	sign.define("errorMarkerError", {
		text = options.error,
		texthl = options.error_group
	})
	sign.define("errorMarkerWarning", {
		text = options.warning,
		texthl = options.warning_group
	})


	-- Setup Autocommand
	vim.cmd [[
		augroup ErrorMarker
			autocmd QuickFixCmdPost make call v:lua.errorMarkerUpdate()
			autocmd CursorHold,CursorMoved * call v:lua.errorMarkerShowMessage() 
		augroup END
	]]

end
