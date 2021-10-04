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

-- File Type Support
au({
	group = "on_read",
	{ "BufRead,BufNewFile", "*.fmt.txt", "set filetype=markdown" },
	{ "BufRead,BufNewFile", "*.svelte", "set filetype=html" },
})

au({
	group = "on_filetype",
	{ "FileType", "markdown,html", "setl spell" },
	{ "FileType", "sh", "setl makeprg=shellcheck\\ -f\\ gcc | compiler shellcheck" },
	{ "FileType", "lua", "setl makeprg=lua\\ -p\\ % | setl errorformat=luac:\\ %f:%l:\\ %m" },
	{ "FileType", "c", "setl makeprg=gcc\\ -Wall\\ -Wextra\\ -g | compiler gcc" },
	{ "FileType", "help,man", "nnoremap <buffer> <CR> <C-]>" },
})

au({
	group = "on_write",
	{ "BufWritePost", "mod.lua", "source <afile> | PackerCompile" },
	{ "BufWritePost", "*.sh,*.lua,*.c", "silent make! <afile> | silent redraw" },
})
