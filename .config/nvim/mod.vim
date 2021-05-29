call plug#begin('~/.vim/plugged')

" Color Scheme
Plug 'sainnhe/gruvbox-material'

" LSP Integration & Linter
Plug 'dense-analysis/ale'

" File Tree
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'

" Icons
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'

" Highlight Colors
Plug 'ap/vim-css-color'

" Language Pack & Compatability
Plug 'sheerun/vim-polyglot'
Plug 'ollykel/v-vim'

" Commenting Plugin
Plug 'tpope/vim-commentary'

if has('nvim')

      " Scrollbar
      Plug 'dstein64/nvim-scrollview'

      " Neovim Terminal Utilities
      Plug 'vimlab/split-term.vim'

endif

call plug#end()
