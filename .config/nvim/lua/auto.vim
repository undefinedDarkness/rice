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
	
	" Set Compiler For Shell
	au FileType sh setlocal makeprg=shellcheck\ -f\ gcc
	
	" For Lua
	au FileType lua setlocal makeprg=luac\ -p\ % | setlocal errorformat=luac:\ %f:%l:\ %m
	
	" Use <CR> to jump topics.
	au FileType help,man nnoremap <buffer> <CR> <C-]>
augroup end

augroup on_write
	" Auto update packer
	au BufWritePost mod.lua source <afile> | PackerCompile 
	
	" Use :make % on write / reading a new file
	au BufWritePost *.sh,*.lua silent make! <afile> | silent redraw!
augroup END

hi ErrorMsg guibg=#282a2e guifg=#cc6666
hi WarningMsg guibg=#282a2e guifg=#f0c674

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
