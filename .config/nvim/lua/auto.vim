

" Auto update packer
au BufWritePost mod.lua source <afile> | PackerCompile 

" Dont Show Line numbers in Terminal 
au TermOpen * setlocal nonumber

" File type Support
augroup on_read
	au BufRead,BufNewFile *.fmt.txt set filetype=html
	au BufRead,BufNewFile *.svelte set filetype=html
	au BufRead,BufNewFile *.yuck set filetype=yuck
augroup END

augroup on_filetype
	" Set Spell Checking In Certain Files.
	" au FileType markdown,html setlocal spell
	" Set Compiler
	au FileType sh setlocal makeprg=shellcheck\ -f\ gcc
augroup end

augroup on_write
	" Use :make % on write 
	autocmd BufWritePost *.sh silent make! <afile> | silent redraw!
augroup END
