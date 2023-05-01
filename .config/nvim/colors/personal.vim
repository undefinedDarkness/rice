" Based on https://lospec.com/palette-list/midnight-ablaze
hi clear
hi Normal guibg=#111111 guifg=#fafafa
hi LineNr guibg=#111111 guifg=#444444
hi VertSplit guibg=#111111 guifg=#222222
hi StatusLine guibg=bg guifg=#333333 gui=underline
hi StatusLineNC guibg=bg guifg=#222222 gui=underline
hi PreProc guifg=#cccccc
hi Constant guifg=#ff8274
hi Keyword guifg=#d3d3d3
hi Visual guibg=#222222 
hi Type guibg=bg guifg=fg gui=bold
hi @type.qualifier gui=none guibg=bg guifg=fg
hi EndOfBuffer guibg=bg guifg=bg
hi Delimiter guifg=#333333
hi MatchParen guibg=bg guifg=#f0f0f0
hi Pmenu guibg=#111111
hi Search guibg=#d53c6a
hi Identifier guifg=fg guibg=bg 
hi Folded guifg=#cccccc guibg=bg
hi SignColumn guibg=bg

hi Title guifg=#d53c6a 
hi @property guifg=#d53c6a 
hi @function guibg=#111111
hi @punctuation.bracket guifg=#666666
hi @punctuation.delimiter guifg=#444444
hi! link @constructor.lua @punctuation.bracket

hi Directory guifg=fg
hi NvimTreeRootFolder guifg=fg gui=none
hi NvimTreeSpecialFile guifg=fg gui=none
hi NvimTreeExecFile guifg=fg gui=none
hi NvimTreeImageFile guifg=fg gui=none

hi! DiagnosticError guifg=#d53c6a guibg=bg
hi! DiagnosticWarn guifg=#888888 guibg=bg
hi! DiagnosticInfo guifg=#888888 guibg=bg

hi! link @repeat Keyword
hi! link Comment LineNr
hi! link CursorLine Visual
hi! link CurSearch Search
hi! link PmenuSel Visual
hi! link Special Normal
hi! link Statement Normal
