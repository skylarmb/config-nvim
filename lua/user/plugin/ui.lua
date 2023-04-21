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
  -- start screen
  {
    "willothy/veil.nvim",
    dependencies = {
      -- All optional, only required for the default setup.
      -- If you customize your config, these aren't necessary.
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      local builtin = require "veil.builtin"
      local current_day = os.date "%A"
      require("veil").setup {
        sections = {
          builtin.sections.oldfiles(),
          builtin.sections.buttons {
            {
              icon = "",
              text = "Find Files",
              shortcut = "p",
              callback = function()
                require("telescope.builtin").find_files()
              end,
            },
            {
              icon = "",
              text = "Find Word",
              shortcut = "f",
              callback = function()
                require("telescope.builtin").live_grep()
              end,
            },
            {
              icon = "󱏔",
              text = "Workspaces",
              shortcut = "w",
              callback = function()
                require("telescope.builtin").buffers()
              end,
            },
            {
              icon = "",
              text = "Diagnostics",
              shortcut = "d",
              callback = function()
                require("telescope.builtin").buffers()
              end,
            },
            {
              icon = "",
              text = "Config",
              shortcut = "c",
              callback = function()
                require("telescope").extensions.file_browser.file_browser {
                  path = vim.fn.stdpath "config",
                }
              end,
            },
          },
        },
        mappings = {},
        startup = true,
        listed = false,
      }
    end,
  },
}
