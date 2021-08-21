local packer = require("packer")

return packer.startup(function()
	use("wbthomason/packer.nvim")

	-- Colorscheme
	use({
		"sainnhe/gruvbox-material",
		config = function()
			require("platform").setup_colorscheme()
		end,
	})

	-- Icons
	use({
		"kyazdani42/nvim-web-devicons",
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
					path = true,
					nvim_lsp = true,
					ultisnips = false,
					luasnip = false,
					nvim_lua = true,
				},
			})
		end,
	})

	-- Code Editiing
	use({
		"tpope/vim-commentary",
		keys = "gc",
	})

	use({
		"editorconfig/editorconfig-vim",
		on = "VimEnter",
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
		"norcalli/nvim-colorizer.lua",
		on = "BufReadPost",
		config = function()
			require("colorizer").setup()
		end,
	})
end)
