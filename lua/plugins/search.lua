function _ADD_CURR_DIR_TO_PROJECTS()
  local historyfile = require("project_nvim.utils.path").historyfile
  vim.notify("Adding current directory to projects")
  vim.notify(historyfile)
  local curr_directory = vim.fn.expand("%:p:h")
  local history = require("project_nvim.utils.history")
  local results = history.get_recent_projects()
  vim.notify(vim.inspect(results))
  -- vim.cmd("!echo " .. curr_directory .. " >> " .. historyfile)
end

return {
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup({
        -- detection_methods = { "pattern" },
        -- patterns = { "package.json" },
        -- show_hidden = true,
        -- -- get a message when project.nvim changes the directory.
        -- silent_chdir = false,
        -- datapath = vim.fn.stdpath("data"),
      })
      vim.cmd("command! ProjectAdd lua _ADD_CURR_DIR_TO_PROJECTS()")
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      { "stevearc/dressing.nvim" },
      { "project.nvim" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      telescope.setup({
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = false, -- override the file sorter
            case_mode = "ignore_case", -- or "ignore_case" or "smart_case"
          },
        },
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          file_ignore_patterns = { "^.git", "^node_modules", "^build/", "^dist/", "^.pnpm/", "^.cache/" },
          pickers = {
            find_files = {
              theme = "dropdown",
            },
            projects = {
              theme = "dropdown",
            },
          },
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
      })
      require("telescope").load_extension("projects")
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("live_grep_args")
    end,
  },
  -- {
  --   "natecraddock/workspaces.nvim",
  --   cmd = { "Workspaces", "WorkspacesOpen" },
  --   opts = {
  --     hooks = {
  --       open = function()
  --         vim.cmd "silent! cd %:p:h"
  --         vim.cmd "Telescope find_files"
  --       end,
  --     },
  --   },
  -- },
  -- fast searching with ag
  { "rking/ag.vim", event = "VeryLazy" },
}
