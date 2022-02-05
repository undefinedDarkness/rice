local M = {}

local function bind(mode, bind, action, opts)
	vim.api.nvim_set_keymap(mode, bind, action, vim.tbl_extend("force", { noremap = true }, opts or {}))
end
M.bind = bind

-- System Clipboard
bind("i", "<C-v>", '<ESC>"+pa')
bind("v", "<C-c>", '"+y')
bind("v", "<C-d>", '"+d')

-- Ctrl-A to select all
bind("", "<C-a>", 'ggVG')

-- F3 to save
bind("", "<F3>", ":update<CR>", { silent = true })

-- F9 to get highlight group
bind("n", "<f9>", ":lua require('ts-info').show_hl_captures()<cr>", {silent=true})

-- File Tree & File Finder
bind("n", "ff", ":Telescope find_files theme=ivy hidden=true<CR>", {silent=true})
bind("n", "if", ":Telescope live_grep theme=ivy<CR>", {silent=true})
bind("n", "bb", ":Telescope buffers theme=ivy<CR>", {silent=true})
bind("n", "hh", ":Telescope highlights theme=ivy<CR>", {silent=true})
bind("n", "<C-f>", ":NvimTreeToggle<CR>", { silent = true })

-- Terminal
bind("n", "<C-t>", ":Term<CR>", { silent = true })

-- More sensible bindings for the wildmenu
bind("c", "<Up>", 'pumvisible() ? "\\<Left>"  : "\\<Up>"', { expr = true })
bind("c", "<Down>", 'pumvisible() ? "\\<Right>" : "\\<Down>"', { expr = true })
bind('c', '<Left>', 'pumvisible() ? "\\<Up>"    : "\\<Left>"', { expr = true })
bind('c', '<Right>', 'pumvisible() ? "\\<Down>"  : "\\<Right>"', { expr = true })

return M
