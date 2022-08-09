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
au({
	group = "on_filetype",
	{ "FileType", "*", 'call v:lua.updateRuler()'},
	{ "FileType", "sh", "setl makeprg=shellcheck\\ -f\\ gcc\\ -x\\ " },
	{ "FileType", "lua", "setl makeprg=luac\\ -p\\ % | setl errorformat=luac:\\ %f:%l:\\ %m" },
	{ "FileType", "help,man", "nnoremap <buffer> <CR> <C-]>" },
})

-- On File Write
au({
	group = "on_write",
	{ "BufWritePost", "mod.lua", "source <afile> | PackerCompile" },
	{ "BufWritePost", "*.sh,*.lua", "silent make! <afile> | silent redraw" },
})

-- Special Commands
vim.cmd [[ cnoreabbrev <expr> Man 'vertical Man' ]]

-- Auto Close Nvim Tree
vim.cmd [[ autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif ]]

return M
