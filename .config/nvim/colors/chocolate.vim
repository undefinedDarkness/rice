" Chocolate Colorscheme
" From: https://gitlab.com/snakedye/chocolate
" Supports:
" Basic User Interface
" Basic Syntax Highlighting
" Treesitter Support For Typescript, C
" Lua
" Markdown
" Shell

" Syntax
hi Statement guifg=#c65f5f gui=none
hi Comment guifg=#665e5c cterm=italic ctermfg=NONE gui=italic
hi Identifier guifg=#728797
hi Underlined guifg=#829e9b
hi Constant guifg=#859e82
hi MatchParen guifg=#d08b65 guibg=none ctermbg=none
hi Special guifg=#d08b65
hi! link SpecialKey Special
hi! link cssSelectorOp Identifier

" Shell
hi shOption guifg=#ab9382 
hi! link shAlias Normal
hi! link shVariable Normal
hi! link shCommandSub Normal
hi! link bashStatement Special
hi! link shQuote Constant
hi! link shNumber Special

hi vimCommentTitle guifg=#ab9382 gui=italic
hi! link Todo vimCommentTitle
hi! link Title Type
hi! link Directory Type
hi! link PreProc Type

" Lua
hi luaFuncId guifg=#998396
hi luaFuncKeyword guifg=#c65f5f 
hi! link luaNumber Special
hi! link luaSpecialValue Special
hi! link luaFuncCall Identifier
hi! link luaBraces Normal

" Markdown
hi markdownCodeDelimiter gui=bold guifg=#3d3837
hi markdownError guifg=#c65f5f
hi htmlH1 guifg=#d08b65
hi! link mkdHeading htmlH1
hi! link htmlH2 htmlH1
hi! link htmlH3 htmlH1
hi! link htmlH4 htmlH1
hi! link htmlH5 htmlH1
hi! link htmlH6 htmlH1
hi! link markdownLinkTextDelimiter Special
hi! link markdownLinkDelimiter Special

hi! link vimHiGuiFgBg Constant
hi! link vimHiGuiRgb Normal
hi! link vimHiAttrib Normal
hi! link vimHiGui    vimHiGuiFgBg
hi! link vimHiCTerm  vimHiGui

" Typescript
hi TSVariableBuiltin guifg=#d9b27c
hi @property guifg=#998396
hi @parameter guifg=#859e82
hi cTSFuncMacro guifg=#d9b27c
hi cStructure guifg=#829e9b
hi cTSConstant guifg=#ab9382
hi TSBoolean guifg=#d08b65
hi cTSKeywordOperator guifg=#829e9b
hi! link @type.qualifier Statement

" Markdown
hi @text.title guifg=#728797 gui=bold
hi! link @text.todo.unchecked cTSConstant 

" Rust
hi! link @storageclass.lifetime cTSConstant

" HTML
hi! link @tag.attribute cTSConstant

" Markdown

hi! link TSConstant TSVariableBuiltin
hi! link @variable Normal
hi! link @type TSVariableBuiltin
hi! link Type @type
hi! link cppNumber Special
hi! link cNumber cppNumber
hi! link TSProperty Normal
hi! link TSNumber luaNumber
hi! link TSConstructor TSVariableBuiltin
hi! link TSPunctBracket Normal
hi! link TSPunctDelimiter Normal

" C Stuff 
hi! link @storageclass Statement
hi! link @type.builtin Statement
hi! link @include Statement
hi! link @define  Statement
hi! link @preproc Statement

" User Interface
hi VertSplit cterm=none gui=none guibg=bg guifg=#302c2b
hi StatusLine guibg=#3d3837 cterm=none gui=none 
hi EndOfBuffer guibg=bg guifg=bg
hi StatusLineNC guibg=#302c2b gui=none cterm=none

hi! link TabLineFill Normal
hi! link TabLine Normal
hi! link TablineSel StatusLine

hi Pmenu guibg=#302c2b
hi PmenuThumb guibg=#3d3837
hi! link PmenuSbar Pmenu

hi Visual guibg=#413c3a
hi Search guibg=#413c3a guifg=#c8bAA4
hi! link IncSearch Visual
hi! link PmenuSel Visual

hi LineNr guifg=#413c3a
hi Folded guibg=#262322 guifg=fg gui=italic
hi! link NormalFloat Normal
hi! link NonText LineNr
hi CursorLine guibg=#302c2b

" Nvim Tree
hi NvimTreeRootFolder guifg=#ab9382 gui=bold
hi NvimTreeSpecialFile gui=italic guifg=#998396
hi NvimTreeExecFile guifg=#c65f5f gui=none 
hi! link NvimTreeImageFile Normal

" Mini.nvim
hi! link MiniStarterItemPrefix NvimTreeExecFile 

" == CUSTOMIZATION ==
" Standard: 
" hi Normal guibg=#252221 guifg=#c8bAA4
" Darker:
hi Normal guibg=#1e1b1a guifg=#c8bAA4


