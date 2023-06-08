THEME = os.getenv("THEME") or "dark"
vim.opt.background = "dark"
vim.cmd("colorscheme kanagawa-kai")

return {
  -- { "echasnovski/mini.colors" },
  -- {
  --   "mcchrish/zenbones.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   dependencies = { "rktjmp/lush.nvim" },
  --   config = function()
  --     vim.opt.background = "light"
  --     vim.g.zenbones_lightness = "dim"
  --     vim.cmd("colorscheme zenbones")
  --   end,
  -- },
  -- {
  --   "sainnhe/gruvbox-material",
  --   lazy = true,
  --   config = function()
  --     vim.g.gruvbox_material_better_performance = 1
  --     -- vim.cmd("colorscheme gruvbox-material")
  --   end,
  -- },
  -- {
  --   "flazz/vim-colorschemes",
  --   lazy = true,
  --   config = function()
  --     -- vim.cmd("colorscheme molokai")
  --   end,
  -- },
  -- {
  --   "sainnhe/sonokai",
  --   lazy = true,
  -- },
  -- {
  --   "Shatur/neovim-ayu",
  --   lazy = true,
  -- },
  -- {
  --   "EdenEast/nightfox.nvim",
  --   lazy = true,
  --   priority = 1000,
  --   opts = {
  --     options = {
  --       transparent = true, -- Disable setting background
  --       styles = { -- Style to be applied to different syntax groups
  --         comments = "italic", -- Value is any valid attr-list value `:help attr-list`
  --       },
  --     },
  --   },
  --   init = function()
  --     vim.cmd("colorscheme terafox")
  --   end,
  -- },
  -- {
  --   "rebelot/kanagawa.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     compile = true, -- enable compiling the colorscheme
  --     statementStyle = { bold = false },
  --     overrides = function(colors)
  --       local theme = colors.theme
  --       return {
  --         TelescopeTitle = { fg = theme.ui.special, bold = true },
  --         TelescopePromptNormal = { bg = theme.ui.bg_p1 },
  --         TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
  --         TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
  --         TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
  --         TelescopePreviewNormal = { bg = theme.ui.bg_dim },
  --         TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
  --         Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
  --         PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
  --         PmenuSbar = { bg = theme.ui.bg_m1 },
  --         PmenuThumb = { bg = theme.ui.bg_p2 },
  --       }
  --     end,
  --   },
  --   init = function()
  --     vim.cmd("colorscheme kanagawa-dragon")
  --   end,
  --   -- dragon ----
  --   chan_add('b', 5,  { filter = 'fg' })
  --   chan_add('saturation', -20)
  --   -- torchlight ----
  --   chan_set('hue', { 36, 109, 40 }, { filter = "fg" })
  --   chan_repel('hue', 200, 100)
  --   chan_set('hue', 327, { filter = "bg" })
  --
  --   -- kanagawa ----
  --   chan_repel('hue', 230, 45)
  --   chan_add('temperature', 20)
  --   chan_add('saturation', -20)
  --   chan_add('b', 2,  { filter = 'fg' })
  --
  --     -- kai --
  --     chan_repel('hue', 39, -180, { filter = "fg" })
  -- chan_add('saturation', 15, { filter = "fg" })
  -- },
  { -- callbacks when system darkmode changes
    "f-person/auto-dark-mode.nvim",
    dependencies = { "zenbones", "lush" },
    enabled = false,
    event = "VeryLazy",
    priority = 1,
    config = function()
      require("auto-dark-mode").setup({
        update_interval = 5000,
        set_light_mode = function()
          vim.opt.background = "light"
          vim.cmd("colorscheme gruvbox-material")
        end,
        set_dark_mode = function()
          vim.opt.background = "dark"
          vim.cmd("colorscheme gruvbox-material")
        end,
      })
      require("auto-dark-mode").init()
    end,
  },
}
