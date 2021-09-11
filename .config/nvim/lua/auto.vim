" Dont Show Line numbers in Terminal 
au TermOpen * setlocal nonumber

augroup on_read
	" File type Support
	au BufRead,BufNewFile *.fmt.txt set filetype=markdown
	au BufRead,BufNewFile *.svelte set filetype=html
augroup END

augroup on_filetype
	" Set Spell Checking In Certain Files.
	au FileType markdown,html setlocal spell
	" Set Compiler
	au FileType sh setlocal makeprg=shellcheck\ -f\ gcc
	" Use <CR> to jump topics.
	au FileType help,man nnoremap <buffer> <CR> <C-]>
augroup end

augroup on_write
	" Auto update packer
	au BufWritePost mod.lua source <afile> | PackerCompile 
	" Use :make % on write / reading a new file
	au BufWritePost *.sh silent make! <afile> | silent redraw!
augroup END
