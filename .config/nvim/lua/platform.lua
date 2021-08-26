local M = {}

-- Enable Mouse Support
vim.opt.mouse = "a"

-- Disable Line Wrappping
vim.opt.wrap = false

-- Line Number & Sign Column
vim.opt.number = true
vim.opt.signcolumn = "number"
vim.opt.termguicolors = true

-- Completion
vim.o.completeopt = "menuone,noselect"

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Statusline
vim.opt.laststatus = 0

-- Indent Line
vim.opt.list = true
vim.opt.listchars = { tab = "│ " }

-- Split below
vim.opt.splitbelow = true

-- Folding
vim.opt.foldmethod = "marker"

-- Ruler
vim.opt.rulerformat = "%l,%c %{&filetype}"
vim.opt.statusline = "⠀"

-- ALE Linters
M.linters = {
	typescript = { "tsserver" },
	c = { "clangd" },
}

-- Colorscheme
vim.opt.background = "dark"
vim.opt.termguicolors = true

vim.cmd [[ 
colorscheme base16-tomorrow-night
]]

vim.g.nvim_tree_show_icons = {
	git = 0,
	folders = 1,
	files = 1,
	folder_arrows = 0,
}
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_width = 25
vim.g.nvim_tree_icon_padding = "  "

-- Disable Default Vim Plugins
vim.g.loaded_gzip = 0
vim.g.loaded_tar = 0
vim.g.loaded_tarPlugin = 0
vim.g.loaded_zipPlugin = 0
vim.g.loaded_2html_plugin = 0
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0
vim.g.loaded_spec = 0
vim.g.loaded_syncolor = 0

return M
