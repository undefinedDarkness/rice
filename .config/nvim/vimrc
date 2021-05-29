" Knife: 🔪 - A Clean And Simple Vim Configuration

" Load Plugins
source  $HOME/.vim/mod.vim

" Vim Settings {{{

" Line Wrapping
set nowrap

" Line Numbers & Signcolumn
set signcolumn=number
set number

" Indentation
filetype indent on
set shiftwidth=2
set softtabstop=2
set expandtab

" Splits
set splitbelow

" Colorscheme 

" Fix: colors not showing for st terminal
if $TERM ==? "st-256color"
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

set termguicolors
set background=dark
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_diagnostic_virtual_text = 'colored'
colorscheme gruvbox-material

" Mouse
set mouse=a
if !has("nvim")
  set ttymouse=sgr
endif
" Backspace
set backspace=indent,eol,start

" Search
set incsearch

" Swap File
set noswapfile

" Statusline 
set laststatus=0
set rulerformat=%=%c,%l\ %{&filetype}

" Wildmenu
set wildmenu

" Folding
set foldmethod=marker

" Auto load file changes
set autoread

" }}}

" Load Configs {{{

" Load matchit
runtime macros/matchit.vim

" ALE Config
source $HOME/.vim/ale.vim

" Fern Config
source $HOME/.vim/fern.vim

" Keyboard Mappings & Autocommands
source $HOME/.vim/bindings.vim

" }}}

" Folding Text {{{

function! Fold_text()
    let line = substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g')
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '  [' . printf("%s", lines_count . ' lines') . '] '
    let foldchar = " "
    let foldtextstart = strpart('  ' . line, 0, (winwidth(0)*2)/3) . lines_count_text
    let foldtextend = repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction

set foldtext=Fold_text()

" }}}
