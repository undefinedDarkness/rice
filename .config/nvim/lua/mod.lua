vim.cmd([[packadd packer.nvim]])

local lisps = {'yuck', 'fennel', 'clojure', 'scheme', 'lisp'}
local packer = require("packer")
return packer.startup(function()
	-- Plugin Manager
	use({
		"wbthomason/packer.nvim",
		cmd = { "PackerSync", "PackerCompile" },
	})

	-- Colorscheme
	use({
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			vim.g.rose_pine_variant = vim.env.TERM == "st-256color" and "dawn" or "base"
			vim.g.rose_pine_disable_italics = (vim.env.TERM == "st-256color")
			vim.cmd([[
			colorscheme rose-pine
			hi EndOfBuffer guifg=bg guibg=bg
			]])
		end,
	})

	-- Nerd Font Icons
	use({
		"kyazdani42/nvim-web-devicons",
		after = "rose-pine",
	})

	-- Tree / Project Drawer
	use({
		"kyazdani42/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeClose" },
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-tree").setup({ 
				auto_close = true,
				hijack_netrw = true,
				update_cwd = true,
				view = {
					width = 20,
					side = 'left'
				}
			})
		end,
	})

	-- Comment
	use({
		"terrortylor/nvim-comment",
		keys = "gc",
		config = function()
			require("nvim_comment").setup()
		end,
	})

	-- HTML Editing
	use({
		"mattn/emmet-vim",
		ft = { "html" },
	})

	-- Terminal
	use({
		"vimlab/split-term.vim",
		cmd = "Term",
	})

	-- Highlight Hex Colors
	use({
		"ap/vim-css-color",
		ft = { "yaml", "css", "html", "text", "lua", "cpp", "fennel" },
		config = function()
			vim.cmd([[ 
			au FileType lua    call css_color#init('hex', 'none', 'luaString,luaComment,luaString2')
			au FileType fennel call css_color#init('hex', 'none', 'fennelString')
			]])
		end,
	})

	-- Lisp Editing
	use({
		'eraserhd/parinfer-rust',
		ft = lisps 
	})

	use({
		'junegunn/rainbow_parentheses.vim',
		ft = lisps,
		config = function()
			vim.fn['rainbow_parentheses#toggle']()
		end
	})

	-- Eww Configuration Language
	use({
		"elkowar/yuck.vim",
		ft = "yuck",
	})

	-- Better highlighting for Lua
	use({
		"tbastos/vim-lua",
		ft = "lua",
	})

	use({
		"mnacamura/vim-fennel-syntax",
		ft = 'fennel'
	})

	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} },
		cmd = {'Telescope'},
		config = function()
			local actions = require("telescope.actions")

			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<esc>"] = actions.close,
							['qq']    = actions.close
						},
					},
				},
			})
		end
	}
end)
