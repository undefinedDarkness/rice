local M = {}

local function bind(mode, bind, action, opts)
	vim.api.nvim_set_keymap(mode, bind, action, vim.tbl_extend("force", { noremap = true }, opts or {}))
end

vim.g.mapleader = " "

-- System Clipboard
bind("i", "<C-v>", '<ESC>"+pa')
bind("v", "<C-c>", '"+y')
bind("v", "<C-d>", '"+d')

-- Ctrl-A to select all
bind("", "<C-a>", 'ggVG')

-- F3 to save
bind("", "<F3>", ":update<CR>", { silent = true })

-- File Tree & File Finder
bind("n", "ff", ":Telescope find_files theme=ivy hidden=true<CR>", {silent=true})
bind("n", "fi", ":Telescope live_grep theme=ivy<CR>", {silent=true})
bind("n", "<C-f>", ":NvimTreeToggle<CR>", { silent = true })

-- Terminal
bind("n", "<C-t>", ":Term<CR>", { silent = true })

-- Indentation
bind("n", "<leader>t", "%retab!<CR>gg=G") -- Spaces -> Tabs
bind("n", "<leader>T", ":setl expandtab | :retab<CR>gg=G") -- Tabs -> Spaces

-- More sensible bindings for the wildmenu
bind("c", "<Up>", 'pumvisible() ? "\\<Left>"  : "\\<Up>"', { expr = true })
bind("c", "<Down>", 'pumvisible() ? "\\<Right>" : "\\<Down>"', { expr = true })
bind('c', '<Left>', 'pumvisible() ? "\\<Up>"    : "\\<Left>"', { expr = true })
bind('c', '<Right>', 'pumvisible() ? "\\<Down>"  : "\\<Right>"', { expr = true })

return M
