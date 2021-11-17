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
		"chriskempson/base16-vim",
		cond = function()
			return vim.env.TERM ~= "st-256color"
		end,
		config = function()
			vim.cmd([[
			colorscheme base16-default-dark
			hi EndOfBuffer guifg=bg
			]])
		end,
	})

	use({
		"jnurmine/Zenburn",
		cond = function()
			return vim.env.TERM == "st-256color"
		end,
		config = function()
			-- vim.g.zenburn_high_Contrast = true
			vim.g.zenburn_italic_Comment = true
			vim.cmd([[
			colorscheme zenburn
			hi EndOfBuffer guifg=bg
			]])
		end,
	})

	-- Nerd Font Icons
	use({
		"kyazdani42/nvim-web-devicons",
		after = "base16-vim"
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
	-- TODO: Integrate with config
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
		requires = { {'nvim-lua/plenary.nvim', cmd = 'Telescope'} },
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
					file_ignore_patterns = { "^.git/" },
					vimgrep_arguments = { "ag", "--vimgrep" }
				},
			})
		end
	}
end)
