-- {{{
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)
	-- }}}

	local has_words_before = function()
		unpack = unpack or table.unpack
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	local feedkey = function(key, mode)
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
	end

	local lisps = { "yuck", "fennel", "clojure", "scheme", "lisp" }
	local lsp = { "c", "rust", "rs", "typescript", "cpp", "v", "zig" }

	local opts = {
		defaults = {
			lazy = true,
		},
	}

	require("lazy").setup({

		{
			'folke/todo-comments.nvim',
			dependencies = { 'nvim-lua/plenary.nvim' },
			config = function()
				require('todo-comments').setup{}
			end,
			event = 'VeryLazy'
		},

		-- LSP
		{
			"neovim/nvim-lspconfig",
			ft = lsp,
			dependencies = {'hrsh7th/cmp-nvim-lsp'},
			config = function()
				local l = require("lspconfig")
				local c = {
					capabilities = require('cmp_nvim_lsp').default_capabilities()
				}
				l.zls.setup(c)
				l.clangd.setup({
					cmd = {"clangd",  "--limit-results=20", "-j=2", "--background-index", "--pch-storage=memory", "--header-insertion=never" },
					capabilities = require('cmp_nvim_lsp').default_capabilities()
				})
				l.rust_analyzer.setup(c)
				l.tsserver.setup(c)
			end,
		},

		{
			'nvim-treesitter/playground',
			dependencies = {'nvim-treesitter'},
			cmd = {"TSHighlightCapturesUnderCursor"},
			config = function() end
		},

		{
			"tikhomirov/vim-glsl",
			ft = "glsl",
		},

		-- Auto Save
		{
			"Pocco81/auto-save.nvim",
			config = function()
				require("auto-save").setup({})
			end,
			event = "VeryLazy",
		},

		-- Tree / Project Drawer
		{
			"kyazdani42/nvim-tree.lua",
			cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeClose" },
			keys = {{"<C-f>", "<cmd>NvimTreeToggle<CR>", silent=true, desc="Open File Tree"}},
			dependencies = "kyazdani42/nvim-web-devicons",
			config = function()
				require("nvim-tree").setup({
					disable_netrw = true,
					hijack_netrw = true,
					update_cwd = true,
					view = {
						width = 20,
						side = "left",
					},
					git = {
						enable = false,
					},
				})
			end,
		},

		{
			'mfussenegger/nvim-dap',
			config = function()
				local dap = require('dap')
				dap.adapters.cppdbg = {
					id = 'cppdbg',
					type = 'executable',
					command = '/home/portal/.vscode/extensions/ms-vscode.cpptools-1.14.5-linux-x64/debugAdapters/bin/OpenDebugAD7',
				}
				local enablePretty = {
					{
						text = '-enable-pretty-printing',
						description = 'enable pretty printing',
						ignoreFailures = false
					}
				}
				dap.configurations.cpp = {
					{
						name = "Launch file",
						type = "cppdbg",
						request = "launch",
						setupCommands = enablePretty,
						program = function()
							return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
						end,
						cwd = '${workspaceFolder}',
						stopAtEntry = true,
					},
					{
						name = 'Attach to gdbserver :1234',
						type = 'cppdbg',
						setupCommands = enablePretty,
						request = 'launch',
						MIMode = 'gdb',
						miDebuggerServerAddress = 'localhost:1234',
						miDebuggerPath = '/usr/bin/gdb',
						cwd = '${workspaceFolder}',
						program = function()
							return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
						end,
					},
				}
				dap.configurations.c = dap.configurations.cpp
				dap.configurations.rust = dap.configurations.cpp
			end
		},

		{
			'NvChad/nvim-colorizer.lua',
			ft = {'lua','css','html','javascript','vim'},
			config = function()
				require('colorizer').setup{
					user_default_options = {
						names = false,
					}
				}
			end
		},

		{
			'rcarriga/nvim-dap-ui',
			dependencies = {
				'nvim-dap'
			},
			lazy = false,
			config = function()
				local dap, dapui = require("dap"), require("dapui")
				dapui.setup()
				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open()
				end
				dap.listeners.before.event_terminated["dapui_config"] = function()
					dapui.close()
				end
				dap.listeners.before.event_exited["dapui_config"] = function()
					dapui.close()
				end
			end
		},

		{
			"nvim-treesitter/nvim-treesitter",
			config = function()
				require("nvim-treesitter.configs").setup({ highlight = { enable = true } })
			end,
			lazy = false,
		},
		-- HTML Editing
		{
			"mattn/emmet-vim",
			ft = { "html" },
		},

		-- use({
			-- 	"ollykel/v-vim",
			-- })

			-- Highlight Hex Colors
			{
				"ap/vim-css-color",
				ft = { "yaml", "css", "html", "text", "lua", "cpp", "fennel", "vim", "scss", "sass" },
				config = function()
					vim.cmd([[
					au FileType lua    call css_color#init('hex', 'none', 'luaString,luaComment,luaString2')
					au FileType fennel call css_color#init('hex', 'none', 'fennelString')
					]])
				end,
			},

			{
				"tpope/vim-commentary",
				lazy = false
			},

			{
				"windwp/nvim-autopairs",
				event = "VeryLazy",
				config = function()
					require('nvim-autopairs').setup{}
				end
			},

			-- Lisp Editing
			{
				"eraserhd/parinfer-rust",
				ft = lisps,
			},

			{
				"junegunn/rainbow_parentheses.vim",
				ft = lisps,
				config = function()
					vim.fn["rainbow_parentheses#toggle"]()
				end,
			},

			-- Eww Configuration Language
			{
				"elkowar/yuck.vim",
				ft = "yuck",
			},


			{
				"folke/zen-mode.nvim",
				cmd = "ZenMode",
				config = function()
					require("zen-mode").setup({
						plugins = {
							options = {
								enabled = true,
								ruler = false,
							},
						},
						on_open = function()
							vim.opt.number = false
						end,
						on_close = function()
							vim.opt.number = true
						end,
					})
				end,
			},

			{
				"glepnir/lspsaga.nvim",
				branch = "main",
				event = 'BufRead',
				dependencies = { "kyazdani42/nvim-web-devicons" },
				keys = {{"<S-r>", "<cmd>Lspsaga rename<CR>", silent=true}},
				config = function()
					require("lspsaga").setup({
						symbol_in_winbar = {
							separator = " / "
						},
						outline = {
							keys = {
								jump = "<CR>"
							}	
						}
					})
				end,
			},

			{
				"mnacamura/vim-fennel-syntax",
				ft = "fennel",
			},

			{
				"hrsh7th/nvim-cmp",
				dependencies = { "hrsh7th/cmp-path", "hrsh7th/cmp-nvim-lsp", "windwp/nvim-autopairs", "hrsh7th/vim-vsnip", "hrsh7th/cmp-vsnip" },
				lazy = false,
				config = function()
					local cmp = require("cmp")
					cmp.setup({
						snippet = {
							expand = function(args) 
								vim.fn["vsnip#anonymous"](args.body)
							end,
						},
						window = {},
						mapping = cmp.mapping.preset.insert({
							["<C-b>"] = cmp.mapping.scroll_docs(-4),
							["<C-f>"] = cmp.mapping.scroll_docs(4),
							["<C-Space>"] = cmp.mapping.complete(),
							["<C-e>"] = cmp.mapping.abort(),
							["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

						}),
						sources = cmp.config.sources({
							{ name = 'nvim_lsp' },
						}, {
							{ name = 'path' }
						})
					})
					cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
				end,
			},

			{
				'abecodes/tabout.nvim',
				event = 'VeryLazy',
				dependencies = {'nvim-treesitter', 'nvim-cmp'},
				config = function()
					require('tabout').setup{
						tabkey = '',
						backwards_tabkey = ''
					}
				end,
			},

			-- General Finding Toolkit
			{
				"nvim-telescope/telescope.nvim",
				cmd = { "Telescope" },
				keys = {
					{"ff", "<cmd>Telescope find_files theme=ivy hidden=true<CR>", silent = true, desc = "File Finder"},
					{"fi", "<cmd>Telescope live_grep theme=ivy<CR>", silent=true, desc="File Search"},
					{"fb", "<cmd>Telescope buffers theme=ivy<CR>", silent=true, desc="Buffer Manager"}
				},
				dependencies = { "kyazdani42/nvim-web-devicons", "nvim-lua/plenary.nvim" },
				config = function()
					local actions = require("telescope.actions")

					require("telescope").setup({
						defaults = {
							prompt_prefix = "λ ",
							-- vimgrep_arguments = { "ag", "--vimgrep" },
							mappings = {
								i = {
									["<esc>"] = actions.close,
									["qq"] = actions.close,
								},
							},
							file_ignore_patterns = { "^.git/" },
						},
					})
				end,
			},
		}, opts)
