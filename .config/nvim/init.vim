
" Plugin Manager
call plug#begin("~/.config/nvim/plugged")

  " Language Compatability
  Plug 'sheerun/vim-polyglot'
  Plug 'euclidianAce/BetterLua.vim'

  " Intellisense
  " Plug 'neoclide/coc.nvim', {'branch': 'release'} -- Replaced by nvim lsp
  Plug 'neomake/neomake'

  " Pretty
  Plug 'itchyny/lightline.vim'
  Plug 'sainnhe/gruvbox-material'
  Plug 'airblade/vim-gitgutter'

  " Fern File Manager
  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/nerdfont.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  Plug 'lambdalisue/glyph-palette.vim'  

  " Run Current File
  " Plug 'thinca/vim-quickrun'

  " Web Development
  Plug 'mattn/emmet-vim'
  " Plug 'bhurlow/vim-parinfer' -- I dont use lisp atm
  Plug 'ap/vim-css-color'

  " Other
  Plug 'mileszs/ack.vim'
  Plug 'Valloric/MatchTagAlways'
  Plug 'tpope/vim-commentary'

  " --- Neovim - Only ---

  " Neovim LSP & Treesitter
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'
  Plug 'onsails/lspkind-nvim'

  Plug 'nvim-treesitter/nvim-treesitter'

  " Other
  Plug 'vimlab/split-term.vim'
  Plug 'dstein64/nvim-scrollview'

call plug#end()

" Prevent FOUT

" -- Fix Compatability For Certain Terminals
" St term
if $TERM ==? "st-256color"
  set t_8f=[38;2;%lu;%lu;%lum
  set t_8b=[48;2;%lu;%lu;%lum
  
  if !has('nvim')
    set ttymouse=sgr
  endif

  " Kitty Term
elseif $TERM ==? "xterm-kitty"
 let &t_ut=''

endif

set termguicolors
set background=dark

let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_better_performance = 1

colorscheme gruvbox-material

" Vim Config
set mouse=a
set nowrap

set number
set title
set hidden
set splitbelow

set expandtab
set shiftwidth=2
set softtabstop=2
set cindent
set smartindent
set autoindent

set noshowmode
set shortmess+=I

set incsearch

set signcolumn=number

filetype indent on
filetype plugin indent on

set encoding=utf-8

set splitbelow

" Include Tab Line & Fern Config & Vim Config
" -- CHANGE
source $HOME/.config/nvim/custom.vim
source $HOME/.config/nvim/fern.vim
source $HOME/.config/nvim/tabline.vim
source $HOME/.config/nvim/lightline.vim

" TODO: Make alt config that uses coc.vim
luafile $HOME/.config/nvim/lsp.lua
