-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/david/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/david/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/david/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/david/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/david/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["emmet-vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/david/.local/share/nvim/site/pack/packer/opt/emmet-vim"
  },
  ["nvim-comment"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\17nvim_comment\frequire\0" },
    keys = { { "", "gc" } },
    loaded = false,
    needs_bufread = false,
    path = "/home/david/.local/share/nvim/site/pack/packer/opt/nvim-comment"
  },
  ["nvim-tree.lua"] = {
    commands = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeClose" },
    config = { "\27LJ\2\nÜ\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\tview\1\0\2\nwidth\3\20\tside\tleft\1\0\3\15update_cwd\2\17hijack_netrw\2\15auto_close\2\nsetup\14nvim-tree\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/david/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua"
  },
  ["nvim-web-devicons"] = {
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/david/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    commands = { "PackerSync", "PackerCompile" },
    loaded = false,
    needs_bufread = false,
    path = "/home/david/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["parinfer-rust"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/david/.local/share/nvim/site/pack/packer/opt/parinfer-rust"
  },
  ["plenary.nvim"] = {
    commands = { "Telescope" },
    loaded = false,
    needs_bufread = false,
    path = "/home/david/.local/share/nvim/site/pack/packer/opt/plenary.nvim"
  },
  ["rainbow_parentheses.vim"] = {
    config = { "\27LJ\2\n=\0\0\2\0\3\0\0056\0\0\0009\0\1\0009\0\2\0B\0\1\1K\0\1\0\31rainbow_parentheses#toggle\afn\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/david/.local/share/nvim/site/pack/packer/opt/rainbow_parentheses.vim"
  },
  ["rose-pine"] = {
    after = { "nvim-web-devicons" },
    loaded = true,
    only_config = true
  },
  ["split-term.vim"] = {
    commands = { "Term" },
    loaded = false,
    needs_bufread = false,
    path = "/home/david/.local/share/nvim/site/pack/packer/opt/split-term.vim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    config = { "\27LJ\2\nÿ\1\0\0\b\0\16\0\0226\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0015\3\14\0005\4\n\0005\5\b\0005\6\5\0009\a\4\0=\a\6\0069\a\4\0=\a\a\6=\6\t\5=\5\v\0045\5\f\0=\5\r\4=\4\15\3B\1\2\1K\0\1\0\rdefaults\1\0\0\25file_ignore_patterns\1\2\0\0\v^.git/\rmappings\1\0\0\6i\1\0\0\aqq\n<esc>\1\0\0\nclose\nsetup\14telescope\22telescope.actions\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/david/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
  },
  ["vim-colors-plain"] = {
    commands = { "ZenMode" },
    loaded = false,
    needs_bufread = false,
    path = "/home/david/.local/share/nvim/site/pack/packer/opt/vim-colors-plain"
  },
  ["vim-css-color"] = {
    config = { "\27LJ\2\nœ\1\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0Ø\1 \n\t\t\tau FileType lua    call css_color#init('hex', 'none', 'luaString,luaComment,luaString2')\n\t\t\tau FileType fennel call css_color#init('hex', 'none', 'fennelString')\n\t\t\t\bcmd\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/david/.local/share/nvim/site/pack/packer/opt/vim-css-color"
  },
  ["vim-fennel-syntax"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/david/.local/share/nvim/site/pack/packer/opt/vim-fennel-syntax"
  },
  ["vim-lua"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/david/.local/share/nvim/site/pack/packer/opt/vim-lua"
  },
  ["yuck.vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/david/.local/share/nvim/site/pack/packer/opt/yuck.vim"
  },
  ["zen-mode.nvim"] = {
    commands = { "ZenMode" },
    config = { "\27LJ\2\n—\1\0\0\3\0\t\0\0146\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\4\0'\2\5\0B\0\2\0016\0\0\0009\0\6\0009\0\a\0'\2\b\0B\0\2\1K\0\1\0003/home/david/rice/scripts/windowsTerminal.sh on\vsystem\afn@\t\t\t\t\t\tcolorscheme plain\n\t\t\t\t\t\thi Normal guibg=#f4f4f4\n\t\t\t\t\t\bcmd\nlight\15background\bopt\bvim´\1\0\0\3\0\t\0\0146\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\4\0'\2\5\0B\0\2\0016\0\0\0009\0\6\0009\0\a\0'\2\b\0B\0\2\1K\0\1\0004/home/david/rice/scripts/windowsTerminal.sh off\vsystem\afn\26colorscheme rose-pine\bcmd\tdark\15background\bopt\bvim∆\1\1\0\5\0\15\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0005\4\4\0=\4\5\3=\3\a\0025\3\t\0005\4\b\0=\4\5\3=\3\n\0023\3\v\0=\3\f\0023\3\r\0=\3\14\2B\0\2\1K\0\1\0\ron_close\0\fon_open\0\fplugins\1\0\0\1\0\2\nruler\1\fenabled\2\vwindow\1\0\0\foptions\1\0\1\vnumber\1\1\0\1\rbackdrop\3\1\nsetup\rzen-mode\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/david/.local/share/nvim/site/pack/packer/opt/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: rose-pine
time([[Config for rose-pine]], true)
try_loadstring("\27LJ\2\n∞\2\0\0\3\0\v\0\0276\0\0\0009\0\1\0006\1\0\0009\1\3\0019\1\4\1\a\1\5\0X\1\2Ä'\1\6\0X\2\1Ä'\1\a\0=\1\2\0006\0\0\0009\0\1\0006\1\0\0009\1\3\0019\1\4\1\6\1\5\0X\1\2Ä+\1\1\0X\2\1Ä+\1\2\0=\1\b\0006\0\0\0009\0\t\0'\2\n\0B\0\2\1K\0\1\0l\t\t\tcolorscheme rose-pine\n\t\t\thi EndOfBuffer guifg=bg guibg=bg\n\t\t\thi Todo guibg=#31748f guifg=#e0def4\n\t\t\t\bcmd\30rose_pine_disable_italics\tbase\tdawn\16st-256color\tTERM\benv\22rose_pine_variant\6g\bvim\0", "config", "rose-pine")
time([[Config for rose-pine]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-web-devicons ]]
time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ZenMode lua require("packer.load")({'vim-colors-plain', 'zen-mode.nvim'}, { cmd = "ZenMode", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Term lua require("packer.load")({'split-term.vim'}, { cmd = "Term", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'plenary.nvim', 'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file PackerSync lua require("packer.load")({'packer.nvim'}, { cmd = "PackerSync", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file PackerCompile lua require("packer.load")({'packer.nvim'}, { cmd = "PackerCompile", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NvimTreeToggle lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NvimTreeOpen lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeOpen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NvimTreeClose lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeClose", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> gc <cmd>lua require("packer.load")({'nvim-comment'}, { keys = "gc", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType yaml ++once lua require("packer.load")({'vim-css-color'}, { ft = "yaml" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'vim-css-color'}, { ft = "css" }, _G.packer_plugins)]]
vim.cmd [[au FileType text ++once lua require("packer.load")({'vim-css-color'}, { ft = "text" }, _G.packer_plugins)]]
vim.cmd [[au FileType lua ++once lua require("packer.load")({'vim-css-color', 'vim-lua'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType lisp ++once lua require("packer.load")({'rainbow_parentheses.vim', 'parinfer-rust'}, { ft = "lisp" }, _G.packer_plugins)]]
vim.cmd [[au FileType clojure ++once lua require("packer.load")({'rainbow_parentheses.vim', 'parinfer-rust'}, { ft = "clojure" }, _G.packer_plugins)]]
vim.cmd [[au FileType yuck ++once lua require("packer.load")({'yuck.vim', 'rainbow_parentheses.vim', 'parinfer-rust'}, { ft = "yuck" }, _G.packer_plugins)]]
vim.cmd [[au FileType fennel ++once lua require("packer.load")({'vim-css-color', 'vim-fennel-syntax', 'rainbow_parentheses.vim', 'parinfer-rust'}, { ft = "fennel" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'vim-css-color', 'emmet-vim'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType scheme ++once lua require("packer.load")({'rainbow_parentheses.vim', 'parinfer-rust'}, { ft = "scheme" }, _G.packer_plugins)]]
vim.cmd [[au FileType cpp ++once lua require("packer.load")({'vim-css-color'}, { ft = "cpp" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/david/.local/share/nvim/site/pack/packer/opt/vim-fennel-syntax/ftdetect/fennel.vim]], true)
vim.cmd [[source /home/david/.local/share/nvim/site/pack/packer/opt/vim-fennel-syntax/ftdetect/fennel.vim]]
time([[Sourcing ftdetect script at: /home/david/.local/share/nvim/site/pack/packer/opt/vim-fennel-syntax/ftdetect/fennel.vim]], false)
time([[Sourcing ftdetect script at: /home/david/.local/share/nvim/site/pack/packer/opt/yuck.vim/ftdetect/yuck.vim]], true)
vim.cmd [[source /home/david/.local/share/nvim/site/pack/packer/opt/yuck.vim/ftdetect/yuck.vim]]
time([[Sourcing ftdetect script at: /home/david/.local/share/nvim/site/pack/packer/opt/yuck.vim/ftdetect/yuck.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
