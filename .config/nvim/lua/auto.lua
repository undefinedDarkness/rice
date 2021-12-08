local M = {}

local function au(x)
	vim.cmd("augroup " .. x.group)
	for _, au in ipairs(x) do
		vim.cmd("au " .. au[1] .. " " .. au[2] .. " " .. au[3])
	end
	vim.cmd("augroup END")
end

-- Dont Show Line numbers in Terminal
au({
	group = "terminal",
	{ "TermOpen", "*", "setlocal nonumber" },
})

-- Open quick fix window automatically
au({
	group = "quickfix",
	{ "QuickFixCmdPost", "[^l]*", "cwindow" },
})

-- On File Open / Read
au({
	group = "on_read",
	{ "BufRead,BufNewFile", "*.fmt.txt", "set filetype=markdown" },
	{ "BufRead,BufNewFile", "*.svelte", "set filetype=html" },
})

-- File Type Support
local spell_complete = vim.api.nvim_replace_termcodes('<C-x><C-k>', true, true, true) 
function M.spell()
	if vim.opt.spell and (vim.fn.pumvisible() == 0) and ((vim.v.char >= 'a' and vim.v.char <= 'z') or (vim.v.char >= 'A' and vim.v.char <= 'Z')) then
		vim.fn.feedkeys(spell_complete, 'n')
	end
end
function M.setup_spell()
	vim.opt.spell = true
	vim.cmd [[ 
	autocmd InsertCharPre * lua require('auto').spell() 
	]]
end

au({
	group = "on_filetype",
	-- { "FileType", "markdown,html", "lua require('auto').setup_spell()" },
	{ "FileType", "sh", "setl makeprg=shellcheck\\ -f\\ gcc | compiler shellcheck" },
	{ "FileType", "lua", "setl makeprg=lua\\ -p\\ % | setl errorformat=luac:\\ %f:%l:\\ %m" },
	-- { "FileType", "c", "setl makeprg=gcc\\ -Wall\\ -Wextra\\ -g | compiler gcc" },
	{ "FileType", "help,man", "nnoremap <buffer> <CR> <C-]>" }
})

-- On File Write
au({
	group = "on_write",
	{ "BufWritePost", "mod.lua", "source <afile> | PackerCompile" },
	{ "BufWritePost", "*.sh,*.lua,*.c", "silent make! <afile> | silent redraw" },
})

return M
