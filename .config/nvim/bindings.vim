
" Help {{{

" Show help
nmap <C-h> :help 

function Help_bindings()
      " Jump to the subject (topic) under the cursor.
      nnoremap <buffer> <CR> <C-]>
      " Return from the last jump.
      nnoremap <buffer> <BS> <C-T>
      " Find the next option 
      nnoremap <buffer> o /'\l\{2,\}'<CR>
      " Find the previous option.
      nnoremap <buffer> O ?'\l\{2,\}'<CR>
      " Find the next subject
      nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>
      " Find the previous subject.
      nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>
endfunction
au FileType help call Help_bindings()

" }}}

" Small Fixes {{{

"  Colors not highlighted in lua
au FileType lua call css_color#init('hex', 'none', 'luaString,luaComment') 

" Rofi file format
autocmd BufNewFile,BufRead *.rasi  set ft=css

" }}}

" Terminal Mode {{{

if !has('nvim')
      tnoremap <silent> <Esc><Esc> <C-w>N
      nmap <silent> <C-t> :term<CR>
else
      au TermOpen * setl nonumber
      nmap <silent> <C-t> :Term<CR>
endif

" }}}

" General {{{

" Open File Tree
nmap <silent> <C-f> :Fern . -drawer -toggle<CR>

" Save File
nmap <F2> :update<CR>
nmap <C-s> :update<CR>

" Open File
nmap <silent> <C-o> :execute ":tabe " . system("zenity --file-selection")<CR>

" Copy Paste {{{
inoremap <C-v> <ESC>"+pa
vnoremap <C-c> "+y
vnoremap <C-d> "+d
" }}}

" }}}

" Scrollbar {{{

let g:scrollview_on_startup = 0
let g:scrollview_current_only = 1

function Toggle_scrollbar()
      if line("$") > 80
            :ScrollViewEnable
      endif
endfunction

au BufRead * call Toggle_scrollbar()

" }}}
