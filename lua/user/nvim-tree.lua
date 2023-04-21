local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local function nvimtree_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { link = "EndOfBuffer" })
  vim.api.nvim_set_hl(0, "NvimTreeNormal", { link = "Normal" })

  vim.keymap.set("n", ".", api.tree.change_root_to_node, opts "CD")
  vim.keymap.set("n", "E", api.tree.collapse_all, opts "Collaps All")
  vim.keymap.set("n", "Y", api.fs.copy.absolute_path, opts "Copy Absolute Path")
  vim.keymap.set("n", "b", api.marks.toggle, opts "Toggle Bookmark")
  vim.keymap.set("n", "c", api.node.run.cmd, opts "Run Command")
  vim.keymap.set("n", "e", api.tree.expand_all, opts "Expand All")
  vim.keymap.set("n", "i", api.node.open.horizontal, opts "Open: Horizontal Split")
  vim.keymap.set("n", "m", "", opts "Noop")
  vim.keymap.set("n", "p", api.node.open.preview, opts "Open Preview")
  vim.keymap.set("n", "s", api.node.open.vertical, opts "Open: Vertical Split")
  vim.keymap.set("n", "t", api.node.open.tab, opts "Open: New Tab")
  vim.keymap.set("n", "<CR>", api.node.open.tab, opts "Open")
  vim.keymap.set("n", "o", api.node.run.system, opts "Run System")
  vim.keymap.set("n", "?", api.tree.toggle_help, opts "Help")
  vim.keymap.set("n", "q", "close", opts "Noop")
  vim.keymap.set("n", "qq", "close", opts "Close")
end

nvim_tree.setup {
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  renderer = {
    root_folder_modifier = ":t",
    icons = {
      git_placement = "after",
      glyphs = {
        git = {
          unstaged = "",
          staged = "",
          unmerged = "",
          renamed = "",
          untracked = "",
          deleted = "",
          ignored = "⊠",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      error = "",
      warning = "",
      hint = "",
      info = "",
    },
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
  },
  update_cwd = false,
  view = {
    width = 30,
  },
  on_attach = nvimtree_on_attach,
}
