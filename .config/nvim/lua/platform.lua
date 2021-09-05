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

-- Modify Some Highlight Groups
vim.cmd [[
	hi ErrorMsg guibg=#282a2e guifg=#cc6666
	hi WarningMsg guibg=#282a2e guifg=#f0c674
]]

-- LSP Setup
function M.setup_lsp()
	local lua_lsp_location = "/home/david/builds/lua-language-server" 
	local lua_lsp_runtime_path = vim.split(package.path, ";")
	lua_lsp_runtime_path[#lua_lsp_runtime_path+1] = "lua/?.lua"
	lua_lsp_runtime_path[#lua_lsp_runtime_path+1] = "lua/?/init.lua"

	local lsp = require("lspconfig")
	lsp.tsserver.setup({})
	lsp.rust_analyzer.setup({})
	lsp.sumneko_lua.setup {
		cmd = { lua_lsp_location.."/bin/Linux/lua-language-server", "-E", lua_lsp_location .. "/main.lua" },
		settings = {
			Lua = {
				runtime = {
					version = 'Lua 5.3',
					path = lua_lsp_runtime_path
				},
				diagnostics = {
					enable = false
				},
				workspace = {
					library = {
						[vim.fn.expand "$VIMRUNTIME/lua"] = true,
						[vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
						["/home/david/builds/awesome/lib"] = true -- Add awesomewm sources.
					}
				}
			}
		},
		root_dir = require('lspconfig.util').root_pattern('.git', 'rc.lua')
	}
end

return M
