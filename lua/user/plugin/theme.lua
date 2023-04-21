return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
  },
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  -- colorscheme
  {
    "sainnhe/gruvbox-material",
    config = function()
      vim.g.gruvbox_material_foreground = "mixed"
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_better_performance = 1
      vim.cmd "colorscheme gruvbox-material"
      vim.api.nvim_set_hl(0, "FloatBorder", { link = "Grey" })
      -- yellow search instead of default puke green
      vim.api.nvim_set_hl(0, "Search", { link = "TSWarning" })
      vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "bg", fg = "bg", blend = 0 })
      vim.api.nvim_set_hl(0, "IncSearch", { link = "TSNote" })
      vim.api.nvim_set_hl(0, "TSTagAttribute", { link = "TSType" })
      vim.api.nvim_set_hl(0, "ErrorText", { undercurl = true, sp = "#ea6962" })
      vim.api.nvim_set_hl(0, "VirtualTextError", { link = "TSComment" })
      vim.api.nvim_set_hl(0, "VirtualTextWarning", { link = "TSComment" })
      vim.api.nvim_set_hl(0, "VirtualTextInfo", { link = "TSComment" })
      vim.api.nvim_set_hl(0, "BufferLineSeparator", { link = "Delimiter" })
      vim.api.nvim_set_hl(0, "BufferLineTabSeparator", { link = "Delimiter" })
      vim.api.nvim_set_hl(0, "BufferLineBackground", { link = "Delimiter" })
      vim.api.nvim_set_hl(0, "BufferLineFill", { link = "Delimiter" })
    end,
  },
  -- show hex colors
  -- { "norcalli/nvim-colorizer.lua", event = "VeryLazy" },
  {
    "ap/vim-css-color",
    ft = { "css", "scss", "less", "sass", "stylus" },
  },
}
