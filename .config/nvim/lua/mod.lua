vim.cmd [[packadd packer.nvim]]

local packer = require("packer")
return packer.startup(function()
	use({
		"wbthomason/packer.nvim",
		cmd = { "PackerSync", "PackerCompile" }
	})

	-- Tree / Project Drawer
	use({
		"kyazdani42/nvim-tree.lua",
		cmd = "NvimTreeToggle",
		requires = { { 'kyazdani42/nvim-web-devicons', opt = true } }
	})

	-- Code Editing

	-- Error Checking
	use "gpanders/editorconfig.nvim"

	-- Comment
	use({
		"terrortylor/nvim-comment",
		keys = "gc",
		config = function()
			require('nvim_comment').setup()
		end
	})
	
	-- Lisp
	use({
		'bhurlow/vim-parinfer',
		ft = { 'lisp', 'clojure', 'yuck' }
	})

	-- Error Marker For :make
	use({
		'$XDG_CONFIG_HOME/nvim/error_marker',
		config = function()
			require('error_marker')()
		end,
		ft = { 'sh', 'lua' }
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
			vim.cmd [[ au FileType lua call css_color#init('hex', 'none', 'luaString,luaComment,luaString2') ]]
		end
	})

	-- Eww's Configuration Language
	use({
		"elkowar/yuck.vim",
		ft = "yuck"
	})

	use({
		"tbastos/vim-lua",
		ft = "lua"
	})
end)
