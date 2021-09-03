vim.cmd [[packadd packer.nvim]]

local packer = require("packer")
return packer.startup(function()
	use({
		"wbthomason/packer.nvim",
		on = 'VimEnter'
	})

	use({
		"onsails/lspkind-nvim",
		after = "nvim-lspconfig",
		config = function()
			require("lspkind").init({
				with_text = false
			})
		end,
	})

	-- Tree / Project Drawer
	use({
		"kyazdani42/nvim-tree.lua",
		cmd = "NvimTreeToggle",
		requires = { { 'kyazdani42/nvim-web-devicons', opt = true } }
	})

	-- Language Server Configurations
	use({
		"neovim/nvim-lspconfig",
		ft = { "typescript", "rust", "lua" },
		config = function()
			require("platform").setup_lsp()
		end,
	})

	-- Auto Completion
	use({
		"hrsh7th/nvim-compe",
		after = "nvim-lspconfig",
		config = function()
			require("compe").setup({
				source = {
					path = true,
					nvim_lsp = true,
					ultisnips = false,
					luasnip = false,
					spell = true
				},
				max_menu_width = 0
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
		ft = { "sh", "lua" },
	})

	use({
		'bhurlow/vim-parinfer',
		ft = { 'lisp', 'clojure', 'yuck' }
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

	use({
		"elkowar/yuck.vim",
		ft = "yuck"
	})
end)
