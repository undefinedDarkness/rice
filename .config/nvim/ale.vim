" Sources
let g:ale_linters = {
      \'sh': ['shellcheck'],
      \'rust': ['analyzer', 'cargo']
      \}

let g:ale_fixers = {
                  \'lua': ['luafmt']
                  \}

" Auto Complete
let g:ale_completion_enabled = 1

" Hovering
let g:ale_set_ballons = 1

" Fix On Save
let g:ale_fix_on_save = 1

" Completion Symbols (Taken from lspkind)
let g:ale_completion_symbols = {
      \'text': ' ',
      \'method': 'ƒ',
      \'function': ' ',
      \'constructor': '',
      \'variable': ' ',
      \'class': ' ',
      \'interface': 'ﰮ ',
      \'module': ' ',
      \'property': ' ',
      \'unit': ' ',
      \'value': ' ',
      \'enum': '了',
      \'keyword': ' ',
      \'snippet': '﬌ ',
      \'color': ' ',
      \'file': ' ',
      \'folder': ' ',
      \'enum member': ' ',
      \'constant': ' ',
      \'struct': ' '
      \}

" Use Clippy If & When Available
if executable('cargo-clippy')
  let g:ale_rust_cargo_use_clippy = 1
else
  let g:ale_rust_cargo_use_check = 1
endif
