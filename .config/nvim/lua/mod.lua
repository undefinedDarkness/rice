vim.cmd([[packadd packer.nvim]])

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
			hi! link BufferOffset Normal
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

	-- Editor Config Support
	use({ "gpanders/editorconfig.nvim", disable = true })

	-- Comment
	use({
		"terrortylor/nvim-comment",
		keys = "gc",
		config = function()
			require("nvim_comment").setup()
		end,
	})

	-- Lisp Editing
	use({
		"bhurlow/vim-parinfer",
		ft = { "lisp", "clojure", "yuck", "fennel" },
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

	-- Tab Line
	use({
		"romgrk/barbar.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			vim.g.bufferline = {
				animation = false,
				auto_hide = true
			}
		end
	})

	-- Highlight Hex Colors
	use({
		"ap/vim-css-color",
		ft = { "yaml", "css", "html", "text", "lua", "cpp" },
		config = function()
			vim.cmd([[ au FileType lua call css_color#init('hex', 'none', 'luaString,luaComment,luaString2') ]])
		end,
	})

	-- Eww Configuration Language
	use({
		"elkowar/yuck.vim",
		ft = "yuck",
		disable = true
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

	use({
		'ollykel/v-vim',
		disable = true
	})
end)
