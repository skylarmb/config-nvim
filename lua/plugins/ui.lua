local defer = require("lib/defer")

local easing = "quadratic"
local base_scalar = 10 -- ms per line scrolled

-- trigger a smooth scroll if a cursor jump would go beyond the window
-- otherwise do normal cursor jump
local function doscroll(lines)
  local normal_key = lines > 0 and "j" or "k"
  -- if vim.g.neovide then
  --   vim.cmd("norm! 10g" .. normal_key)
  --   return
  -- end

  local neoscroll = require("neoscroll")
  local duration_ms = math.abs(lines) * base_scalar
  -- local indent = require("indent_blankline.commands")

  local smooth_scroll = defer.throttle_leading(function()
    -- indent.refresh(false, true)
    neoscroll.scroll(lines, true, duration_ms, easing)
  end, 50)

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
      smooth_scroll()
    else
      vim.cmd("norm! 10g" .. normal_key)
    end
  end
end

return {
  -- UI libs used by some plugins
  { "nvim-lua/plenary.nvim", lazy = false },
  { "MunifTanjim/nui.nvim", event = "VeryLazy" },
  { "nvim-tree/nvim-web-devicons", lazy = false },
  -- nicer quickfix window
  { "kevinhwang91/nvim-bqf", event = "VeryLazy" },
  -- smooth scroll
  {
    "karb94/neoscroll.nvim",
    lazy = false,
    config = function()
      local neoscroll = require("neoscroll")

      neoscroll.setup({
        mappings = { "<C-u>", "<C-b>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        hide_cursor = true,
        cursor_scrolls_alone = true,
        easing_function = easing,
        respect_scrolloff = false,
        pre_hook = function()
          vim.cmd("doautocmd User ScrollStart")
        end,
        post_hook = function()
          vim.cmd("doautocmd User ScrollEnd")
          duration_scalar = 0
        end,
        performance_mode = false,
      })
    end,
    init = function()
      local nvx = { "n", "v", "x" }
      -- J/K scroll faster, but not as fast as PageUp/PageDown
      -- vim.keymap.set(nvx, "K", doscroll(-10), { remap = true, silent = true })
      -- vim.keymap.set(nvx, "J", doscroll(10), { remap = true, silent = true })
      vim.keymap.set(nvx, "K", "10gk", { remap = false, silent = true })
      vim.keymap.set(nvx, "J", "10gj", { remap = false, silent = true })
    end,
  },
  -- smooth cursor jump
  {
    "echasnovski/mini.animate",
    enabled = false,
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
    event = { "VimEnter" },
    opts = {
      components = {
        "nvim", -- Nvim notifications (vim.notify and such)
      },
      component_name_recall = true,
    },
  },
  -- breadcrumbs
  {
    "SmiteshP/nvim-navic",
    event = "User FileOpened",
  },
  -- dynamic identation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufRead",
    opts = {},
  },
  -- -- start screen
  { "mhinz/vim-startify", lazy = false },

  {
    "aznhe21/actions-preview.nvim",
  },
}
