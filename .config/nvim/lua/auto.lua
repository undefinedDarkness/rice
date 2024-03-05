local M = {}

local function au(x)
	local id = vim.api.nvim_create_augroup(x.group, {})
	for _, au in ipairs(x) do
		vim.api.nvim_create_autocmd(x.event, {
			pattern = au[1],
			command = au[2],
			group = id,
		})
	end
end

-- Dont Show Line numbers in Terminal
au({
	group = "terminal",
	event = "TermOpen",
	{ "*", "setlocal nonumber" },
	{ "*", "startinsert" },
})

-- Open quick fix window automatically
au({
	group = "quickfix",
	event = "QuickFixCmdPost",
	{ "[^l]*", "cwindow" },
})

-- On File Open / Read
au({
	group = "on_read",
	event = { "BufRead", "BufNewFile" },
	{ "*.fmt.txt", "set filetype=markdown" },
	{ "*.svelte", "set filetype=html" },
	{ "*.v", "set ft=v" },
	{ "*.vs,*.fs", "set filetype=glsl" },
})

-- File Type Support
au({
	group = "on_filetype",
	event = "FileType",
	-- { "*", "call v:lua.updateRuler()" },
	{ "sh", "setl makeprg=shellcheck\\ -f\\ gcc\\ -x\\ " },
	{ "lua", "setl makeprg=luac\\ -p\\ % | setl errorformat=luac:\\ %f:%l:\\ %m" },
	{ "help,man", "nnoremap <buffer> <CR> <C-]>" },
})

-- On File Write
au({
	group = "on_write",
	event = "BufWritePost",
	{ "*.sh,*.lua", "silent make! <afile> | silent redraw" },
})

-- On Vim Exit

-- Special Commands
vim.cmd([[ cnoreabbrev <expr> Man 'vertical Man' ]])

-- Auto Close Nvim Tree
vim.cmd([[ autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif ]])

-- Auto Close quickfix
vim.cmd([[ au WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif ]])

vim.cmd([[
function! Syn()
  for id in synstack(line("."), col("."))
    echo synIDattr(id, "name") . ' -> ' . synIDattr(synIDtrans(id), 'name')
  endfor
endfunction
command! -nargs=0 Syn call Syn()
]])

return M
