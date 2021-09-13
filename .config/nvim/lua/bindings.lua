local bind = function(mode, bind, action, slient)
	vim.api.nvim_set_keymap(mode, bind, action, { noremap = true, silent = slient or false })
end

vim.g.mapleader = " "

-- System Clipboard
bind("i", "<C-v>", '<ESC>"+pa')
bind("v", "<C-c>", '"+y')
bind("v", "<C-d>", '"+d')

-- F3 to save
bind("", "<F3>", ":update<CR>", true)

-- File Tree
bind("n", "<C-f>", ":NvimTreeToggle<CR>", true)

-- Indentation
bind("n", "<leader>t", ":%retab!<CR>gg=G") -- Spaces -> Tabs
bind("n", "<leader>T", ":set expandtab | :retab<CR>gg=G") -- Tabs -> Spaces
