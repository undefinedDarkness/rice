local lsp = require('lspconfig')
local lsp_compe = require('compe')

-- Setup Languagn Servers
lsp.rust_analyzer.setup{
  settings = {
    ["rust-analyzer.checkOnSave.command"] = "clippy"
  }
}
lsp.denols.setup{
  init_options = {
    enable = true,
    lint = true,
    unstable = true
  }
}
lsp.cssls.setup{}
--lsp.clangd.setup{}

-- Compe Specific Vim Options
vim.cmd("set completeopt=menuone,noinsert,noselect")
vim.cmd("set shortmess+=c")

-- Setup LSP Kind For Fancy Symbols
require('lspkind').init {}

-- Compe
lsp_compe.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
  };
}
