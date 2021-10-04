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
vim.cmd([[ syntax on ]])

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

-- Ruler, Statusline & Title
vim.opt.rulerformat = "%l,%c %{&filetype}"
vim.opt.statusline = "::"
vim.opt.titlestring = "NVIM: %f"
vim.opt.title = true

-- Colorscheme
vim.opt.background = "dark"

-- Nvim Tree
vim.g.nvim_tree_show_icons = {
	git = 0,
	folders = 1,
	files = 1,
	folder_arrows = 0,
}
vim.g.nvim_tree_width = 20
vim.g.nvim_tree_icon_padding = "  "

vim.g.user_emmet_leader_key = "<leader>i"

vim.opt.grepprg = "grep -nHbFr"
vim.opt.grepformat = "%f:%l:%c:%m"

-- Disable Default Nvim Plugins {{{
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_2html_plugin = 1
-- }}}

-- Find highlight group
function M.SynStack()
	if not vim.fn.exists("*synstack") then
		return
	end
	local o = vim.fn.synstack(vim.fn.line("."), vim.fn.col("."))
	for k, v in ipairs(o) do
		o[k] = vim.fn.synIDattr(v, "name")
	end
	print(vim.inspect(o))
end

vim.cmd([[
function! Grep(...)
	return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
]])

return M
