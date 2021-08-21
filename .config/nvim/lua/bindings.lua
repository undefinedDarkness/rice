local bind = vim.api.nvim_set_keymap

vim.g.mapleader = " "

-- System Clipboard
bind("i", "<C-v>", '<ESC>"+pa', { noremap = true })
bind("v", "<C-c>", '"+y', { noremap = true })
bind("v", "<C-d>", '"+d', { noremap = true })

-- F3 to save
bind("", "<F3>", ":update<CR>", { noremap = true, silent = true })

-- Help: Press enter to jump
vim.cmd([[ au FileType help,man nnoremap <buffer> <CR> <C-]>]])

-- File Tree
bind("n", "<C-f>", ":NvimTreeToggle<CR>", { silent = true, noremap = true })

-- Indentation
bind("n", "<leader>t", ":%retab!<CR>gg=GG", { noremap = true }) -- Spaces -> Tabs
bind("n", "<leader>T", ":set expandtab | :retab<CR>", { noremap = true }) -- Tabs -> Spaces
