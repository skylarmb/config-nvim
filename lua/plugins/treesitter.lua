return {
  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle",
        lazy = true,
      },
      { "nvim-treesitter/nvim-tree-docs" },
      { "nvim-treesitter/nvim-treesitter-context" },
      { "nvim-treesitter/nvim-treesitter-textobjects" },
    },
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        tree_docs = { enable = true },
        auto_install = true,
        ensure_installed = {
          "lua",
          "markdown",
          "markdown_inline",
          "bash",
          "python",
          "typescript",
          "regex",
        },
        incremental_selection = { enable = true },
        textobjects = { enable = true },
        sync_install = false,
        highlight = {
          enable = true, -- false will disable the whole extension
          custom_captures = {
            ["tsxTag"] = "TSSymbol",
            ["tsxTagName"] = "TSSymbol",
            ["constructor"] = "TSSymbol",
          },
        },
        autopairs = {
          enable = true,
        },
        indent = { enable = true, disable = { "python" } },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      })
    end,
  },
  -- treesitter powered auto-closing tags for html, tsx, etc.
  { "windwp/nvim-ts-autotag", event = "InsertEnter" },
  -- context aware comment formatting, e.g. for jsx render() fn
  { "JoosepAlviste/nvim-ts-context-commentstring", event = "VeryLazy" },
}
