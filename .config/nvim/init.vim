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

" For Nvim-Compe
set completeopt=menuone,noselect

" }}}

" Plugin Configs {{{

" ALE:
let g:ale_linters = {
      \'sh': ['shellcheck'],
      \'rust': ['cargo'],
      \'lua': ['luafmt']
      \}
let g:ale_fix_on_save = 1

if executable('cargo-clippy')
  let g:ale_rust_cargo_use_clippy = 1
else
  let g:ale_rust_cargo_use_check = 1
endif

if !has('nvim') 
  let g:ale_completion_enabled = 1
endif

" }}}

" Load Configs {{{

" Load matchit
runtime macros/matchit.vim

" Neovim Language Server
if has('nvim')
  luafile $HOME/.vim/lsp.lua
endif

" Fern Config
source $HOME/.vim/fern.vim

" Keyboard Mappings & Autocommands
source $HOME/.vim/bindings.vim

" }}}


