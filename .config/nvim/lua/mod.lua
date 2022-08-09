vim.cmd([[packadd packer.nvim]])


local lisps = {'yuck', 'fennel', 'clojure', 'scheme', 'lisp'}
local packer = require("packer")

return packer.startup(function()
	-- Plugin Manager
	use({
		"wbthomason/packer.nvim",
		cmd = { "PackerSync", "PackerCompile" },
	})

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		ft = { "c", "rust", "rs" },
		config = function()
			local l = require("lspconfig")
			l.clangd.setup{}
			l.rust_analyzer.setup{}
		end
	})

	use({
		"echasnovski/mini.nvim",
		config = function()
			require("mini.comment").setup {}

			require("mini.completion").setup {
				set_vim_settings = true,
				fallback_action = nil
			}
		end
	})

	-- Tree / Project Drawer
	use({
		"kyazdani42/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeClose" },
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-tree").setup({ 
				-- auto_close = true,
				hijack_netrw = true,
				update_cwd = true,
				view = {
					width = 20,
					side = 'left'
				}
			})
			if vim.env.TERM == 'xterm' then
				vim.g.nvim_tree_show_icons = {
					git = 0,
					folders = 0,
					files = 0,
					folder_arrows =0
				}
			end
		end,
	})

	use({ 
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require'nvim-treesitter.configs'.setup { highlight = { enable = true } }
		end
	})
	-- HTML Editing
	use({
		"mattn/emmet-vim",
		ft = { "html" },
	})

	use({
		"ollykel/v-vim",
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
		ft = { "yaml", "css", "html", "text", "lua", "cpp", "fennel", "vim", "scss", "sass" },
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

	use {
		"folke/zen-mode.nvim",
		cmd = 'ZenMode',
		config = function()
			require("zen-mode").setup {
				plugins = {
					options = {
						enabled = true,
						ruler = false
					}
				},
				on_open = function()
					vim.opt.number = false
				end,
				on_close = function()
					vim.opt.number = true
				end
			}
		end
	}

	use({
		"mnacamura/vim-fennel-syntax",
		ft = 'fennel'
	})

	use({
		"savq/melange",
		disable = true,
		config = function() 
			vim.cmd [[ colo melange ]]
		end
	})

	-- General Finding Toolkit
	use {
		'nvim-telescope/telescope.nvim',
		cmd = {'Telescope'},
		requires = {  "kyazdani42/nvim-web-devicons", "nvim-lua/plenary.nvim" },
		config = function()
			local actions = require("telescope.actions")

			require("telescope").setup({
				defaults = {
					prompt_prefix = 'λ ',
					-- vimgrep_arguments = { "ag", "--vimgrep" },
					mappings = {
						i = {
							["<esc>"] = actions.close,
							['qq']    = actions.close
						},
					},
					file_ignore_patterns = { "^.git/" },
				},
			})
		end
	}
end)
