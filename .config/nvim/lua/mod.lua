vim.cmd([[packadd packer.nvim]])

local packer = require("packer")
return packer.startup(function()
	-- Plugin Manager
	use({
		"wbthomason/packer.nvim",
		cmd = { "PackerSync", "PackerCompile" },
	})

	use({
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			vim.g.rose_pine_variant = vim.env.TERM == "st-256color" and "dawn" or "base"
			vim.g.rose_pine_disable_italics = (vim.env.TERM == "st-256color")
			vim.cmd([[ colorscheme rose-pine ]])
			vim.cmd([[ hi EndOfBuffer guifg=bg guibg=bg ]])
		end,
	})

	use({
		"kyazdani42/nvim-web-devicons",
		after = "rose-pine",
	})

	-- Tree / Project Drawer
	use({
		"kyazdani42/nvim-tree.lua",
		cmd = "NvimTreeToggle",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-tree").setup({ auto_close = true })
		end,
	})

	-- Code Editing
	use("gpanders/editorconfig.nvim")

	-- Comment
	use({
		"terrortylor/nvim-comment",
		keys = "gc",
		config = function()
			require("nvim_comment").setup()
		end,
	})

	-- Lisp
	use({
		"bhurlow/vim-parinfer",
		ft = { "lisp", "clojure", "yuck" },
	})

	-- Easy Editing for HTML
	use({
		"mattn/emmet-vim",
		ft = { "html" },
	})

	-- Terminal
	use({
		"vimlab/split-term.vim",
		cmd = "Term",
	})

	-- Syntax Highlighting

	-- Highlight Hex Colors
	use({
		"ap/vim-css-color",
		ft = { "yaml", "css", "html", "text", "lua", "cpp" },
		config = function()
			vim.cmd([[ au FileType lua call css_color#init('hex', 'none', 'luaString,luaComment,luaString2') ]])
		end,
	})

	use({
		"elkowar/yuck.vim",
		ft = "yuck",
	})

	use({
		"tbastos/vim-lua",
		ft = "lua",
	})
end)
