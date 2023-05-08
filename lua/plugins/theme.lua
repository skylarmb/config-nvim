-- pause illuminate and colorizer on large files
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    local line_count = vim.api.nvim_buf_line_count(0)
    if line_count >= 5000 then
      vim.cmd("IlluminatePauseBuf")
    end
  end,
})

return {
  -- colorscheme
  -- {
  --   "local/matcha",
  --   dev = true,
  --   config = function()
  --     -- apply theme
  --     vim.cmd([[
  --       set background=light
  --       colorscheme matcha
  --     ]])
  --     vim.api.nvim_set_hl(0, "illuminatedWord", { link = "LspReferenceText" })
  --   end,
  -- },
  {
    "sainnhe/gruvbox-material",
    dev = false,
    lazy = false,
    config = function()
      vim.cmd([[
        set background=light
        colorscheme gruvbox-material
      ]])
      -- set highlight overrides
      -- vim.cmd("hi NonText cterm=NONE ctermfg=NONE")
      -- vim.api.nvim_set_hl(0, "FloatBorder", { link = "Grey" })
      -- vim.api.nvim_set_hl(0, "Search", { link = "TSWarning" }) -- yellow (default is puke green)
      -- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "bg", fg = "bg", blend = 0 })
      -- vim.api.nvim_set_hl(0, "IncSearch", { link = "TSNote" })
      -- vim.api.nvim_set_hl(0, "TSTagAttribute", { link = "TSType" })
      -- vim.api.nvim_set_hl(0, "ErrorText", { undercurl = true, sp = "#ea6962" })
      -- vim.api.nvim_set_hl(0, "VirtualTextError", { link = "TSComment" })
      -- vim.api.nvim_set_hl(0, "VirtualTextWarning", { link = "TSComment" })
      -- vim.api.nvim_set_hl(0, "VirtualTextInfo", { link = "TSComment" })
      -- vim.api.nvim_set_hl(0, "BufferLineSeparator", { link = "Delimiter" })
      -- vim.api.nvim_set_hl(0, "BufferLineTabSeparator", { link = "Delimiter" })
      -- vim.api.nvim_set_hl(0, "BufferLineBackground", { link = "Delimiter" })
      -- vim.api.nvim_set_hl(0, "BufferLineFill", { link = "Delimiter" })
      -- vim.api.nvim_set_hl(0, "SidebarNvimLineNr", { link = "CursorLineNr" })
      -- vim.api.nvim_set_hl(0, "SidebarNvimLspDiagnosticsError", { link = "DiagnosticSignError" })
      -- vim.api.nvim_set_hl(0, "SidebarNvimLspDiagnosticsWarning", { link = "DiagnosticSignWarn" })
      -- vim.api.nvim_set_hl(0, "SidebarNvimLspDiagnosticsInfo", { link = "DiagnosticSignWarn" })
      -- vim.api.nvim_set_hl(0, "SidebarNvimLspDiagnosticsHint", { link = "DiagnosticSignHint" })
      -- vim.api.nvim_set_hl(0, "ExtraWhitespace", { link = "SpellBad" })
      -- vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { link = "CursorLine" })
      -- vim.api.nvim_set_hl(0, "SignColumn", { link = "StatusLine" })
      -- vim.api.nvim_set_hl(0, "LineNr", { link = "StatusLine" })
      -- vim.api.nvim_set_hl(0, "illuminatedWord", { link = "LspReferenceText" })
    end,
  },
  { "rktjmp/lush.nvim" },
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup({
        -- filetype overrides
      }, {
        -- default options
        "*",                 -- Highlight all files, but customize some others.
        RGB = true,          -- #RGB hex codes
        RRGGBB = true,       -- #RRGGBB hex codes
        names = false,       -- "Name" codes like Blue
        RRGGBBAA = true,     -- #RRGGBBAA hex codes
        rgb_fn = true,       -- CSS rgb() and rgba() functions
        hsl_fn = true,       -- CSS hsl() and hsla() functions
        css = true,          -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,       -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background
        mode = "background", -- Set the display mode.
      })
    end,
    init = function()
      -- enable colorizer for any language that has an LSP
      vim.api.nvim_create_autocmd({ "LspAttach" }, {
        callback = function()
          vim.cmd("ColorizerAttachToBuffer")
          -- refresh hex color code highlighting when not editing (can get out of sync)
        end,
      })
      vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
        callback = function()
          vim.cmd("ColorizerReloadAllBuffers")
        end,
      })
    end,
  },
  -- { "ap/vim-css-color", },
}
