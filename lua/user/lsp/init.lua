-- local status_ok, _ = pcall(require, "lspconfig")
-- if not status_ok then
--   return
-- end
--
-- require "user.lsp.mason"
-- require("user.lsp.handlers").setup()
-- require "user.lsp.null-ls"

require('mason').setup({
  ui = {
    border = 'rounded'
  }
})

local lsp = require("lsp-zero").preset {"recommended"}

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps { buffer = bufnr }
end)

-- (Optional) Configure lua language server for neovim
require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

lsp.set_server_config({
  single_file_support = false,
})
lsp.skip_server_setup({'denols'})
lsp.set_sign_icons({
  error = '✖',
  warn =  '⚠',
  hint = '⚑',
  info = '»'
})
require('lspconfig').tsserver.setup({
  root_dir = function()
    return lsp.dir.find_first({'pnpm-workspace.yaml'})
  end,
})


lsp.setup()
