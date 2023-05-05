return {
  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
      { "nvim-treesitter/nvim-treesitter-context" },
    },
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        auto_install = true,
        ensure_installed = {
          "lua",
          "markdown",
          "markdown_inline",
          "bash",
          "python",
          "typescript",
        },
        sync_install = false,
        highlight = {
          enable = true, -- false will disable the whole extension
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
  -- illuminate expression under cursor
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
      require("illuminate").configure({
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
        delay = 200,
        filetypes_denylist = {
          "dirvish",
          "fugitive",
          "alpha",
          "NvimTree",
          "packer",
          "neogitstatus",
          "Trouble",
          "lir",
          "Outline",
          "spectre_panel",
          "toggleterm",
          "DressingSelect",
          "TelescopePrompt",
        },
        filetypes_allowlist = {},
        modes_denylist = {},
        modes_allowlist = {},
        providers_regex_syntax_denylist = {},
        providers_regex_syntax_allowlist = {},
        under_cursor = true,
      })
    end,
    init = function()
      vim.g.Illuminate_ftblacklist = { "alpha", "NvimTree" }
      vim.api.nvim_set_keymap(
        "n",
        "<a-n>",
        '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>',
        { noremap = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<a-p>",
        '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
        { noremap = true }
      )
    end,
  },
}
