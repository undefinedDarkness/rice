local function au(rest)
	vim.cmd("autocmd " .. rest)
end

-- Auto update packer
au([[ BufWritePost mod.lua source <afile> | PackerCompile ]])

-- In Terminal Dont Show Linenumbers
au([[ TermOpen * setlocal nonumber ]])

-- Filetype Support
au([[ BufRead,BufNewFile *.fmt.txt set filetype=html ]])
au([[ BufRead,BufNewFile *.svelte set filetype=html ]])
