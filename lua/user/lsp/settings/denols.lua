local lspconfig = require "lspconfig"

return {
  -- root_dir = lspconfig.util.root_pattern("pnpm-workspace.yaml", ".git"),
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
}
