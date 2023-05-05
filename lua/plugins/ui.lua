return {
  -- UI libs used by some plugins
  { "nvim-lua/plenary.nvim" },
  { "MunifTanjim/nui.nvim", event = "VeryLazy" },
  { "kyazdani42/nvim-web-devicons" },
  -- nicer quickfix window
  { "kevinhwang91/nvim-bqf", event = "VeryLazy" },
  -- smooth scroll
  {
    "karb94/neoscroll.nvim",
    config = function()
      local neoscroll = require("neoscroll")
      local easing = "quadratic"
      local duration_scalar = 10 -- duration (ms) per line scrolled

      neoscroll.setup({
        mappings = { "<C-u>", "<C-b>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        hide_cursor = true,
        cursor_scrolls_alone = true,
        easing_function = easing,
        respect_scrolloff = true,
        pre_hook = function() -- skip minianimate cursor during scrolls
          vim.g.minianimate_disable = true
        end,
        post_hook = function() -- enable minianimate cursor after scrolls
          vim.g.minianimate_disable = false
        end,
      })
      -- trigger a smooth scroll if a cursor jump would go beyond the window
      -- otherwise do normal cursor jump
      local function doscroll(lines)
        local normal_key = lines > 0 and "j" or "k"
        return function()
          local height = vim.api.nvim_win_get_height(0)
          local next = vim.fn.winline() + lines
          local scroll = true
          -- don't scroll if we're at the top
          if lines < 0 and not ((next - 1) <= 0) then
            scroll = false
          end
          -- don't scroll if we're at the bottom
          if lines > 0 and not ((next + 1) > height) then
            scroll = false
          end
          if scroll then
            neoscroll.scroll(lines, true, math.abs(lines) * duration_scalar, easing)
          else
            vim.cmd("norm! 10g" .. normal_key)
          end
        end
      end
      local nvx = { "n", "v", "x" }
      -- J/K scroll faster, but not as fast as PageUp/PageDown
      vim.keymap.set(nvx, "K", "", { remap = true, silent = true, callback = doscroll(-10) })
      vim.keymap.set(nvx, "J", "", { remap = true, silent = true, callback = doscroll(10) })
    end,
  },
  -- smooth cursor jump
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function()
      -- don't use animate when scrolling with the mouse
      -- local mouse_scrolled = false
      -- for _, scroll in ipairs { "Up", "Down" } do
      --   local key = "<ScrollWheel" .. scroll .. ">"
      --   vim.keymap.set({ "", "i" }, key, function()
      --     mouse_scrolled = true
      --     return key
      --   end, { expr = true })
      -- end
      local animate = require("mini.animate")
      return {
        cursor = {
          enable = true,
          timing = animate.gen_timing.quadratic({ duration = 80, unit = "total" }),
        },
        resize = { enable = false },
        scroll = { enable = false }, -- neoscroll is a better scrolling plugin
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
      component_name_recall = true,
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
      "telescope.nvim",
      "plenary.nvim",
      -- "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      local builtin = require("veil.builtin")
      local current_day = os.date("%A")
      require("veil").setup({
        sections = {
          builtin.sections.oldfiles(),
          builtin.sections.buttons({
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
                require("telescope").extensions.file_browser.file_browser({
                  path = vim.fn.stdpath("config"),
                })
              end,
            },
          }),
        },
        mappings = {},
        startup = true,
        listed = false,
      })
    end,
  },
}