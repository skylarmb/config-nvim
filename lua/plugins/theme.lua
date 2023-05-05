return {
  -- colorscheme
  {
    "local/gruvbox-material",
    dev = true,
    config = function()
      -- dark theme
      -- vim.g.gruvbox_material_foreground = "mixed"
      -- vim.g.gruvbox_material_background = "medium"
      -- vim.g.gruvbox_material_foreground = "material"
      -- vim.g.gruvbox_material_background = "soft"

      -- light theme
      -- vim.g.gruvbox_material_foreground = "material"
      -- vim.g.gruvbox_material_background = "hard"

      -- apply theme
      vim.g.gruvbox_material_better_performance = 1
      vim.cmd("colorscheme gruvbox-material")

      -- set highlight overrides
      vim.cmd("hi NonText cterm=NONE ctermfg=NONE")
      vim.api.nvim_set_hl(0, "FloatBorder", { link = "Grey" })
      vim.api.nvim_set_hl(0, "Search", { link = "TSWarning" }) -- yellow (default is puke green)
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
      vim.api.nvim_set_hl(0, "SidebarNvimLineNr", { link = "CursorLineNr" })
      vim.api.nvim_set_hl(0, "SidebarNvimLspDiagnosticsError", { link = "DiagnosticSignError" })
      vim.api.nvim_set_hl(0, "SidebarNvimLspDiagnosticsWarning", { link = "DiagnosticSignWarn" })
      vim.api.nvim_set_hl(0, "SidebarNvimLspDiagnosticsInfo", { link = "DiagnosticSignWarn" })
      vim.api.nvim_set_hl(0, "SidebarNvimLspDiagnosticsHint", { link = "DiagnosticSignHint" })
      vim.api.nvim_set_hl(0, "ExtraWhitespace", { link = "SpellBad" })
      vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { link = "CursorLine" })
    end,
  },
  -- show hex colors
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup({
          -- filetype overrides
        },
        {
          -- default options
          "*",                     -- Highlight all files, but customize some others.
          RGB      = true,         -- #RGB hex codes
          RRGGBB   = true,         -- #RRGGBB hex codes
          names    = false,        -- "Name" codes like Blue
          RRGGBBAA = true,         -- #RRGGBBAA hex codes
          rgb_fn   = true,         -- CSS rgb() and rgba() functions
          hsl_fn   = true,         -- CSS hsl() and hsla() functions
          css      = true,         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn   = true,         -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes: foreground, background
          mode     = 'background', -- Set the display mode.
        })
    end
  },
  -- { "ap/vim-css-color", },
}
