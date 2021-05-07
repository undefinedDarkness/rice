" -- Custom Commands --
command W :w
command Qa :qa

" -- Vim Tweaks --

" Man page support
let g:mkdp_auto_start = 0

" Hide ~
highlight EndOfBuffer ctermfg=black ctermbg=black

" Italic Rust Comments
highlight rustCommentLineDoc cterm=italic gui=italic term=italic guifg=#a9b665

" Rust Analyzer - Inlay Hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

" Fern Text
highlight FernRoot cterm=bold gui=bold term=bold

" Rofi-Rasi File Support
au BufNewFile,BufRead /*.rasi setf css

" Clean Horizontal Splits
highlight! StatusLineNC gui=underline guibg=NONE cterm=underline guifg=#3e4451 

" Fern Folder's are blue
highlight GlyphPaletteDirectory guifg=#7daea3 

" No line numbers in terminal
autocmd TermOpen * setlocal nonumber 

" Lua Hex Color Highlight
au FileType lua call css_color#init('hex', 'none', 'luaString,luaComment') 

" Set title
set titlestring=Editing:\ %f

" Paste
set pastetoggle=<F2>

" -- Plugin Config --

" Neomake
call neomake#configure#automake('w')

" Ack
let g:ackprg = "grep -PrnbaHi --color=never"
cnoreabbrev Ack Ack!
set shellpipe=> " Prevent Ack Output Leaking Into Terminal

" -- Keyboard Remappings --

" F3 to save
noremap <silent> <F3>  :update<CR>
vnoremap <silent> <F3> <C-C>:update<CR>
inoremap <silent> <F3> <C-O>:update<CR>

" F7 to format a document
nmap <F7> gg=G<C-o><C-o>

" Open Terminal On Ctrl - T
nnoremap <C-T> :Term<Enter>

" Ctrl+C/Ctrl+V to copy/paste to/from system clipboard
inoremap <C-v> <ESC>"+pa
vnoremap <C-c> "+y
vnoremap <C-d> "+d

" Ctrl - F to open Fern
nnoremap <silent> <C-f> :Fern . -drawer -toggle<CR>

" Ctrl A to save
nmap <C-a> <esc>ggVG<CR>

" -- Functions --

" Entr Job For Current File
function! EntrJob(cmd)
  silent exec "!(echo '" .. expand('%:p') .."' | entr -p " .. a:cmd .. " &) > /dev/null"
endfunc

" Highlight Group Under Cursor
function! HighlightGroup()
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Sort Lines By Length
function! SortLines() range
    execute a:firstline . "," . a:lastline . 's/^\(.*\)$/\=strdisplaywidth( submatch(0) ) . " " . submatch(0)/'
    execute a:firstline . "," . a:lastline . 'sort! n'
    execute a:firstline . "," . a:lastline . 's/^\d\+\s//'
endfunction
vnoremap <C-l>  :'<,'>call SortLines()<CR>
