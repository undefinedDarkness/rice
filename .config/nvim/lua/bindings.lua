local M = {}

local function bind(mode, bind, action, opts)
	if type(action) == "function" then
     vim.keymap.set(mode,bind,action,vim.tbl_extend("force",{noremap=true}, opts or {}))
	else 
		vim.api.nvim_set_keymap(mode, bind, action, vim.tbl_extend("force", { noremap = true }, opts or {}))
	end
end
M.bind = bind

-- Pane movement
bind("n", "<C-1>", "<C-w><UP>")
bind("n", "<C-3>", "<C-w><LEFT>")
bind("n", "<C-4>", "<C-w><RIGHT>")
bind("n", "<C-2>", "<C-w><DOWN>")


-- System Clipboard
bind("i", "<C-v>", '<ESC>"+pa')
bind("v", "<C-c>", '"+y')
bind("v", "<C-d>", '"+d')

-- Ctrl-A to select all
bind("", "<C-a>", "ggVG")

-- F3 to save
bind("", "<F3>", ":update<CR>", { silent = true })

-- F4 to format
bind("", "<F4>", ":lua vim.lsp.buf.format()<CR>", { silent = true })

-- F9 to get highlight group
-- bind("n", "<f9>", ":TSHighlightCapturesUnderCursor<CR>", { silent = true })

-- Terminal
bind('t', '<Esc>', [[<C-\><C-n>]])
bind("n", "<C-`>", ":split term://bash<CR>", { silent = true })

-- More sensible bindings for the wildmenu
bind("c", "<Up>", 'pumvisible() ? "\\<Left>"  : "\\<Up>"', { expr = true })
bind("c", "<Down>", 'pumvisible() ? "\\<Right>" : "\\<Down>"', { expr = true })
bind("c", "<Left>", 'pumvisible() ? "\\<Up>"    : "\\<Left>"', { expr = true })
bind("c", "<Right>", 'pumvisible() ? "\\<Down>"  : "\\<Right>"', { expr = true })

-- <TAB> Bindings 
-- {{{
local function replace_keycodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.tab_binding()
  if vim.fn.pumvisible() ~= 0 then
    return replace_keycodes("<C-n>")
  elseif vim.fn["vsnip#available"](1) ~= 0 then
    return replace_keycodes("<Plug>(vsnip-expand-or-jump)")
  else
    return replace_keycodes("<Plug>(Tabout)")
  end
end
	
function _G.s_tab_binding()
  if vim.fn.pumvisible() ~= 0 then
    return replace_keycodes("<C-p>")
  elseif vim.fn["vsnip#jumpable"](-1) ~= 0 then
    return replace_keycodes("<Plug>(vsnip-jump-prev)")
  else
    return replace_keycodes("<Plug>(TaboutBack)")
  end
end

bind("i", "<Tab>", "v:lua.tab_binding()", {expr = true})
bind("i", "<S-Tab>", "v:lua.s_tab_binding()", {expr = true})
-- }}}

-- Nvim DAP Keybindings
-- {{{
   -- vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
   --  vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
   --  vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
   --  vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
   --  vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
   --  vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
   --  vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
   --  vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
   --  vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
   --  vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
   --    require('dap.ui.widgets').hover()
   --  end)
   --  vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
   --    require('dap.ui.widgets').preview()
   --  end)
   --  vim.keymap.set('n', '<Leader>df', function()
   --    local widgets = require('dap.ui.widgets')
   --    widgets.centered_float(widgets.frames)
   --  end)
   --  vim.keymap.set('n', '<Leader>ds', function()
   --    local widgets = require('dap.ui.widgets')
   --    widgets.centered_float(widgets.scopes)
   --  end)
-- }}}

return M
