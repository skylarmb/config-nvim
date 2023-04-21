return {
  -- UI libs used by some plugins
  { "nvim-lua/plenary.nvim" },
  { "MunifTanjim/nui.nvim", event = "VeryLazy" },
  -- illuminate expression under cursor
  { "RRethy/vim-illuminate", event = "VeryLazy" },
  -- nicer quickfix window
  { "kevinhwang91/nvim-bqf", event = "VeryLazy" },
  -- cursor and window animations
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function()
      -- -- don't use animate when scrolling with the mouse
      -- local mouse_scrolled = false
      -- for _, scroll in ipairs({ "Up", "Down" }) do
      --   local key = "<ScrollWheel" .. scroll .. ">"
      --   vim.keymap.set({ "", "i" }, key, function()
      --     mouse_scrolled = true
      --     return key
      --   end, { expr = true })
      -- end
      --
      local animate = require "mini.animate"
      return {
        cursor = {
          enable = true,
          timing = animate.gen_timing.exponential { duration = 80, unit = "total" },
          -- Animate for 200 milliseconds with linear easing
          -- timing = animate.gen_timing.quartic({ duration = 50, unit = 'total' }),
        },
        resize = {
          enable = false,
        },
        scroll = {
          enable = false,
        },
      }
    end,
    config = function(_, opts)
      require("mini.animate").setup(opts)
    end,
  },
  -- unobstrusive notifier
  {
    "vigoux/notifier.nvim",
    opts = {
      components = { -- Order of the components to draw from top to bottom (first nvim notifications, then lsp)
        "nvim", -- Nvim notifications (vim.notify and such)
        "lsp", -- LSP status updates
      },
    },
  },
  -- breadcrumbs
  {
    "SmiteshP/nvim-navic",
    event = "User FileOpened",
  },
  -- file tree
  { "kyazdani42/nvim-tree.lua" },
  { "kyazdani42/nvim-web-devicons" },
}
