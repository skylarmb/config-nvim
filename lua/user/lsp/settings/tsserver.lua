local lspconfig = require "lspconfig"

return {
  -- cmd = {
  --   "nc",
  --   "localhost",
  --   "11222",
  -- },
  -- cmd = {
  --   "nc",
  --   "localhost",
  --   "11223",
  -- },
  -- cmd = { "tsserver_d" },
  -- root_dir = lspconfig.util.root_pattern("pnpm-workspace.yaml", ".git"),
  -- cmd_cwd = lspconfig.util.root_pattern("pnpm-workspace.yaml", ".git")(),
  settings = {
    completions = {
      completeFunctionCalls = true,
    },
  },
}

-- Error executing vim.schedule lua callback: ...r/neovim/HEAD-2b35de3/share/nvim/runtime/lua/vim/lsp.lua:1309: RPC[Error] code_name = InternalErro
-- r, message = "Request initialize failed with message: The \"initialize\" request has already called before."
-- stack traceback:
--         [C]: in function 'assert'
--         ...r/neovim/HEAD-2b35de3/share/nvim/runtime/lua/vim/lsp.lua:1309: in function ''
--         vim/_editor.lua: in function <vim/_editor.lua:0>
-- Press ENTER or type command to continue
