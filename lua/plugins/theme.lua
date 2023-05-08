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
  -- {
  --   "sainnhe/gruvbox-material",
  -- },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    dependencies = {
      { "rktjmp/lush.nvim" },
    },
    config = function()
      local lush = require("lush")
      local hsl = lush.hsl
      local hsluv = lush.hsluv

      vim.opt.background = "light"
      -- setup must be called before loading the colorscheme
      -- Default options:
      local tint = hsluv("#D4cb8c")
      local function colorize(c)
        return hsluv(c).sa(-20).mix(tint, 10).hex
      end
      local p = {
        seafoam = hsluv("#a4b07e"),
        matcha = hsluv("#707c4f"),
        moss = hsluv("#424106"),
        cream = hsluv("#D4cb8c"),
        blush = hsluv("#c6a685"),
        coffee = hsluv("#6d4930"),
      }
      local seed = p.moss
      local lightness = 40
      local saturation = 60
      local scalar = 50
      local tint = 20
      local normalized = seed.lightness(lightness)


      local function mix(n)
        return normalized.ro(scalar * n).mix(seed, tint).saturate(saturation)
      end
      local green = mix(0)
      local aqua = mix(1)
      local blue = mix(1.5).de(20)
      local purple = mix(4.5).de(50)
      local red = mix(5.8).de(20)
      local orange = mix(6).sa(20)
      local yellow = mix(6.5).sa(50)
      local gray = mix(0).de(80)


      local fg = hsluv("#6d4930")
      local alt_fg = hsluv("#654735")
      local bg = hsluv("#fbf1c7").mix(seed, 10)
      local fg_inverse = bg
      local function light(c)
        local ch = hsluv(c)
        return ch.mix(seed.lightness(ch.l), 5).hex
      end
      local function bright(c)
        return c.sa(50).hex
      end
      local function neutral(c)
        return c.sa(25).hex
      end



      require("gruvbox").setup({
        contrast = "soft", -- can be "hard", "soft" or empty string
        palette_overrides = {
          dark0_hard = "#1d2021",
          dark0 = "#282828",
          dark0_soft = "#32302f",
          dark1 = "#3c3836",
          dark2 = "#504945",
          dark3 = "#665c54",
          dark4 = "#7c6f64",
          light0_hard = light("#f9f5d7"),
          light0 = light("#fbf1c7"),
          light0_soft = light("#f2e5bc"),
          light1 = light("#ebdbb2"),
          light2 = light("#d5c4a1"),
          light3 = light("#bdae93"),
          light4 = light("#a89984"),
          bright_red = bright(red),
          bright_green = bright(green),
          bright_yellow = bright(yellow),
          bright_blue = bright(blue),
          bright_purple = bright(purple),
          bright_aqua = bright(aqua),
          bright_orange = bright(orange),
          neutral_red = neutral(red),
          neutral_green = neutral(green),
          neutral_yellow = neutral(yellow),
          neutral_blue = neutral(blue),
          neutral_purple = neutral(purple),
          neutral_aqua = neutral(aqua),
          neutral_orange = neutral(orange),
          faded_red = red.hex,
          faded_green = green.hex,
          faded_yellow = yellow.hex,
          faded_blue = blue.hex,
          faded_purple = purple.hex,
          faded_aqua = aqua.hex,
          faded_orange = orange.hex,
          gray = gray.hex,
        },
        overrides = {
          Normal = { fg = hsluv("#6d4930").hex },    -- colorize("#654735")
          GruvboxFg0 = { fg = hsluv("#6d4930").hex } -- colorize("#654735")
        },
        dim_inactive = false,
        transparent_mode = false,
      })
      vim.cmd("colorscheme gruvbox")
    end
  },
  --   dev = false,
  --   lazy = false,
  --   config = function()
  --     vim.cmd([[
  --       set background=light
  --       colorscheme gruvbox-material
  --     ]])
  --     -- set highlight overrides
  --     -- vim.cmd("hi NonText cterm=NONE ctermfg=NONE")
  --     -- vim.api.nvim_set_hl(0, "FloatBorder", { link = "Grey" })
  --     -- vim.api.nvim_set_hl(0, "Search", { link = "TSWarning" }) -- yellow (default is puke green)
  --     -- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "bg", fg = "bg", blend = 0 })
  --     -- vim.api.nvim_set_hl(0, "IncSearch", { link = "TSNote" })
  --     -- vim.api.nvim_set_hl(0, "TSTagAttribute", { link = "TSType" })
  --     -- vim.api.nvim_set_hl(0, "ErrorText", { undercurl = true, sp = "#ea6962" })
  --     -- vim.api.nvim_set_hl(0, "VirtualTextError", { link = "TSComment" })
  --     -- vim.api.nvim_set_hl(0, "VirtualTextWarning", { link = "TSComment" })
  --     -- vim.api.nvim_set_hl(0, "VirtualTextInfo", { link = "TSComment" })
  --     -- vim.api.nvim_set_hl(0, "BufferLineSeparator", { link = "Delimiter" })
  --     -- vim.api.nvim_set_hl(0, "BufferLineTabSeparator", { link = "Delimiter" })
  --     -- vim.api.nvim_set_hl(0, "BufferLineBackground", { link = "Delimiter" })
  --     -- vim.api.nvim_set_hl(0, "BufferLineFill", { link = "Delimiter" })
  --     -- vim.api.nvim_set_hl(0, "SidebarNvimLineNr", { link = "CursorLineNr" })
  --     -- vim.api.nvim_set_hl(0, "SidebarNvimLspDiagnosticsError", { link = "DiagnosticSignError" })
  --     -- vim.api.nvim_set_hl(0, "SidebarNvimLspDiagnosticsWarning", { link = "DiagnosticSignWarn" })
  --     -- vim.api.nvim_set_hl(0, "SidebarNvimLspDiagnosticsInfo", { link = "DiagnosticSignWarn" })
  --     -- vim.api.nvim_set_hl(0, "SidebarNvimLspDiagnosticsHint", { link = "DiagnosticSignHint" })
  --     -- vim.api.nvim_set_hl(0, "ExtraWhitespace", { link = "SpellBad" })
  --     -- vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { link = "CursorLine" })
  --     -- vim.api.nvim_set_hl(0, "SignColumn", { link = "StatusLine" })
  --     -- vim.api.nvim_set_hl(0, "LineNr", { link = "StatusLine" })
  --     -- vim.api.nvim_set_hl(0, "illuminatedWord", { link = "LspReferenceText" })
  --   end,
  -- },
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
