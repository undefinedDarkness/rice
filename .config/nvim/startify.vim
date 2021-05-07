function! StartifyEntryFormat()
        call glyph_palette#apply()
        return 'nerdfont#find(absolute_path) ."  ". entry_path'
endfunction

function s:todo_list()
        let parts = systemlist($HOME . "/Documents/Scripts/todo.sh output-awesome")
        let x = []
        for part in parts
                let subparts = split(part, ":") 
                call add(x, { 'line': subparts[1] . ": " . subparts[2] })
        endfor
        return x
endfunction

let g:startify_files_number = 6
let g:startify_enable_special = 0
let g:startify_session_sort = 1
let g:startify_custom_indices = []
let g:startify_lists = [
          \ { 'type': 'files',     'header': ['      Recently Opened'] },
          \ { 'type': function('s:todo_list'), 'header': ['     Todo'] }
          \]

let g:startify_custom_header = startify#center([
                        \'      __...--~~~~~-._   _.-~~~~~--...__',
                        \"    //               `V'               \\\\ ",
                        \'   //                 |                 \\ ',
                        \'  //__...--~~~~~~-._  |  _.-~~~~~~--...__\\ ',
                        \' //__.....----~~~~._\ | /_.~~~~----.....__\\',
                        \'====================\\|//====================',
                        \'                    `---`'
                        \])
