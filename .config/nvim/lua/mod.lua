vim.cmd [[packadd packer.nvim]]

local packer = require("packer")
return packer.startup(function()
	use({
		"wbthomason/packer.nvim",
		cmd = { "PackerSync", "PackerCompile" }
	})

	-- Icons
	use({
		"kyazdani42/nvim-web-devicons",
		opt = true,
		config = function()
			require("nvim-web-devicons").setup()
		end,
	})

	use({
		"onsails/lspkind-nvim",
		after = "nvim-lspconfig",
		config = function()
			require("lspkind").init({})
		end,
	})

	-- Tree / Project Drawer
	use({
		"kyazdani42/nvim-tree.lua",
		after = "nvim-web-devicons",
		cmd = "NvimTreeToggle",
		setup = function()
			vim.g.nvim_tree_show_icons = {
				git = 0,
				folders = 1,
				files = 1,
				folder_arrows = 0,
			}
			vim.g.nvim_tree_auto_close = 1
			vim.g.nvim_tree_width = 25
			vim.g.nvim_tree_icon_padding = "  "
		end,
	})

	-- Language Server Configurations
	use({
		"neovim/nvim-lspconfig",
		ft = { "css", "typescript", "rust", "c", "go" },
		config = function()
			local lsp = require("lspconfig")
			lsp.cssls.setup({})
			lsp.tsserver.setup({})
			lsp.gopls.setup({})
			lsp.rust_analyzer.setup({})
			lsp.clangd.setup({})
		end,
	})

	-- Auto Completion
	use({
		"hrsh7th/nvim-compe",
		after = "nvim-lspconfig",
		config = function()
			require("compe").setup({
				enabled = true,
				autocomplete = true,
				source = {
					path = { kind = "" },
					nvim_lsp = { kind = "" },
					ultisnips = false,
					luasnip = false,
					nvim_lua = { kind = "" },
				},
			})
		end,
	})

	-- Code Editiing
	use({
		"terrortylor/nvim-comment",
		keys = "gc",
		config = function()
			require('nvim_comment').setup()
		end
	})

	use({
		"dense-analysis/ale",
		on = "BufReadPost",
		ft = { "sh" },
	})

	-- Terminal
	use({
		"vimlab/split-term.vim",
		cmd = "Term",
	})

	-- Syntax Highlighting
	use({
		"ap/vim-css-color",
		ft = { "yaml", "css", "html", "text", "lua", "cpp" },
		config = function()
			vim.cmd [[ au FileType lua call css_color#init('hex', 'none', 'luaString,luaComment,luaString2') ]]
		end
	})
end)
