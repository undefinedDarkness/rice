" -- Lightline Config --

" Auto-toggles statusline based on window size
function! CheckWindowSize()
  " -- CHANGE
  if winwidth(0) > 100 && winheight(0) > 30
    set laststatus=2
    set noshowmode
  else
    set laststatus=0
    set showmode
  endif
endfunction
call CheckWindowSize()
autocmd VimResized * :call CheckWindowSize()


let g:lightline = {
      \ 'colorscheme': 'gruvbox_material',
      \ 'active': {
      \     'left': [ [ 'custom_filename' ], [], [ 'filetype' ] ],
      \     'right': [ [], [], [ 'custom_position' ] ]
      \  },
      \ 'inactive': {
      \     'left': [],
      \     'right': []
      \  },
      \ 'enable': {
      \   'tabline': 0
      \ },
      \ 'component_function': {
      \     'custom_filename': 'CustomFileName',
      \     'custom_position': 'CustomPosition' 
      \   }
      \ }

" --- Lightline Functions ---

function! CustomPosition()
  let cursor = getcurpos()
  return cursor[1] . ":" . cursor[2]
endfunction

function! CustomFileName()
  let file = expand('%')
  if file =~? "fern://"
    return "  Fern"
  elseif file =~? "!/bin/bash"
    return "  Shell"
  else
    return nerdfont#find(@%) . "  " . file
  endif
endfunction

function! GetTabFileName(n)
	  let buflist = tabpagebuflist(a:n)
	  let winnr = tabpagewinnr(a:n)
	  let bufname = bufname(buflist[winnr - 1])
    
    if bufname =~? "fern://"
      return "  Fern"
    endif

    return nerdfont#find(bufname) . "  " . bufname
endfunction
