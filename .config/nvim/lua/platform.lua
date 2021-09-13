local M = {}

-- Enable Mouse Support
vim.opt.mouse = "a"

-- Disable Line Wrappping
vim.opt.wrap = false

-- Line Number & Sign Column
vim.opt.number = true
vim.opt.signcolumn = "number"

-- Colorscheme
vim.opt.termguicolors = true
vim.cmd [[ syntax on ]]
vim.g.colors_name = "base16-tomorrow-night"

-- Completion
vim.o.completeopt = "menuone,noselect"

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Statusline
vim.opt.laststatus = 0

-- Indent Line
--vim.opt.list = true
--vim.opt.listchars = { tab = "│ " }

-- Split below
vim.opt.splitbelow = true

-- Folding
vim.opt.foldmethod = "marker"

-- Ruler
vim.opt.rulerformat = "%l,%c %{&filetype}"
vim.opt.statusline = "⠀"

-- Colorscheme
vim.opt.background = "dark"

-- Nvim Tree
vim.g.nvim_tree_show_icons = {
	git = 0,
	folders = 1,
	files = 1,
	folder_arrows = 0,
}
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_width = 25
vim.g.nvim_tree_icon_padding = " "

-- Disable Default Nvim Plugins
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_2html_plugin = 1

-- Set GCC Warning / Error Format
vim.opt.errorformat = "%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," .. vim.api.nvim_get_option("errorformat")

return M
