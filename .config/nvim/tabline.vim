function MyTabLine()
	  let s = ''
	  for i in range(tabpagenr('$'))
	    " select the highlighting
	    if i + 1 == tabpagenr()
	      let s .= '%#TabLineSel#'
	    else
	      let s .= '%#TabLine#'
	    endif

	    " set the tab page number (for mouse clicks)
	    let s .= '%' . (i + 1) . 'T'

	    " the label is made by MyTabLabel()
	    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
	  endfor

	  " after the last tab fill with TabLineFill and reset tab page nr
	  let s .= '%#TabLineFill#%T'

	  return s
endfunction

function! MyTabLabel(n)
	  let buflist = tabpagebuflist(a:n)
	  let winnr = tabpagewinnr(a:n)
	  let bufname = bufname(buflist[winnr - 1])
    
    if bufname =~? "fern://"
      return "  Fern"
    endif

    return nerdfont#find(bufname) . "  " . bufname
endfunction

" Tabline Colors
highlight TabLineFill guibg=none
highlight TabLine guibg=#282828 guifg=#d4be98
highlight TabLineSel guibg=#3c3836 guifg=#d4be98

set tabline=%!MyTabLine()
