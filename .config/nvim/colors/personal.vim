" Based on https://lospec.com/palette-list/midnight-ablaze
hi clear

" Layout
hi Normal guibg=#111111 guifg=#f2f7f2
hi LineNr guibg=#111111 guifg=#444444
hi VertSplit guibg=#111111 guifg=#222222
hi StatusLine guibg=bg guifg=#333333 gui=underline
hi EndOfBuffer guibg=bg guifg=bg
hi SignColumn guibg=bg
hi StatusLineNC guibg=bg guifg=#222222 gui=underline
hi Title guifg=#d53c6a
hi Pmenu guibg=#111111
hi TabLineSel guibg=#111111
hi TabLine guibg=#000000 gui=none
hi! link TabLineFill TabLine
hi! link CursorLine Visual
hi! link CurSearch Search
hi! link PmenuSel Visual

" Telescope
hi link TelescopeBorder VertSplit
hi link TelescopeTitle Title
hi TelescopeMatching guibg=#222222 gui=bold 
hi TelescopePromptNormal guifg=fg

" Markdown
hi @text.todo.unchecked guifg=#666666 guibg=bg

" Editing
hi MatchParen guibg=bg guifg=#f0f0f0
hi Visual guibg=#222222 
hi Search guibg=#d53c6a
hi Folded guifg=#cccccc guibg=bg
hi Directory guifg=fg
hi link NonText Normal

" Language
hi PreProc guifg=#cccccc
hi Constant guifg=#ff8274
hi Delimiter guifg=#333333
hi Type guibg=bg guifg=fg gui=bold
hi Identifier guifg=fg guibg=bg 
hi Keyword guifg=#b0b0b0
hi link @exception Keyword
hi link Conditional Keyword
hi @type.qualifier gui=none guibg=bg guifg=fg
hi @function guibg=#111111
hi @punctuation.bracket guifg=#666666
hi @punctuation.delimiter guifg=#444444
hi @property guifg=#888888
hi! link Comment LineNr
hi link @function.builtin Keyword
hi link @constant.builtin Constant
hi! link @storageclass Normal
hi! link @repeat Keyword
hi! link Special Normal
hi! link Statement Normal
" Languge Specific:
hi! link @constructor.lua @punctuation.bracket

" NvimTree
hi NvimTreeFileIgnored guifg=#888888
hi NvimTreeSymlink guifg=fg gui=none
hi NvimTreeRootFolder guifg=#d53c6a  
hi NvimTreeSpecialFile guifg=fg gui=none
hi NvimTreeExecFile guifg=fg gui=none
hi NvimTreeImageFile guifg=fg gui=none

" CMP
hi CmpItemMenu guifg=#333333
hi CmpItemKind guifg=#cccccc
" Diagnostics:
hi! DiagnosticError guifg=#d53c6a guibg=bg
" Possible: #FCF6BD
hi! DiagnosticWarn guifg=#888888 guibg=bg
" Possible: #C7EAE4
hi! DiagnosticInfo guifg=#888888 guibg=bg
hi Todo guifg=bg guibg=#888888 gui=bold
" Type Colors:
" #6D72C3 #3C6997
