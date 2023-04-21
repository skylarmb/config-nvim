return {
  -- {
  --   "nvim-telescope/telescope-fzf-native.nvim",
  -- },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      "natecraddock/workspaces.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      local telescope = require "telescope"
      local actions = require "telescope.actions"
      telescope.setup {
        extensions = {
          fzf = {
            case_mode = "ignore_case",
          },
        },
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          file_ignore_patterns = { ".git/", "node_modules" },
          -- pickers = {
          --   find_files = {
          --     theme = "dropdown",
          --   },
          -- },
          find_command = { "fzf" },
          path_display = { "absolute" },
          wrap_results = true,
          mappings = {
            i = {
              ["<Down>"] = actions.cycle_history_next,
              ["<Up>"] = actions.cycle_history_prev,
              ["<Esc>"] = actions.close,
              ["<CR>"] = actions.select_default,
              -- ["<C-n>"] = actions.move_selection_next,
              -- ["<C-k>"] = actions.move_selection_previous,
            },
          },
          layout_strategy = "vertical",
          layout_config = {
            width = 0.7,
            vertical = { height = 0.8 },
            -- other layout configuration here
          },
        },
      }

      telescope.load_extension "workspaces"
    end,
  },
  {
    "natecraddock/workspaces.nvim",
    cmd = { "Workspaces", "WorkspacesOpen" },
    opts = {
      hooks = {
        open = function()
          -- require("persistence").load()
          vim.cmd "silent! cd %:p:h"
          vim.cmd "Telescope find_files"
        end,
      },
    },
  },
  -- fast searching with ag
  { "rking/ag.vim", event = "VeryLazy" },
}
