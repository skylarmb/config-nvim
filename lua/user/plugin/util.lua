return {
  -- session management
  {
    "rmagatti/auto-session",
    cmd = { "SaveSession", "DeleteSession", "RestoreSession" },
  }, -- session management
  -- repl / debugger
  { "tpope/vim-scriptease", event = "VeryLazy", ft = { "lua", "viml" } }, -- lua/viml repl / debugger
  -- Bdelete!
  { "moll/vim-bbye", lazy = false },
  -- seamless jumping between tmux panes and buffers
  {
    "alexghergh/nvim-tmux-navigation",
    opts = {
      disable_when_zoomed = true, -- defaults to false
    },
  },
  { "akinsho/toggleterm.nvim", cmd = "ToggleTerm" },
  { "AckslD/nvim-neoclip.lua", event = "VeryLazy" },
  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    opts = {
      signs = {
        add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
      },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      watch_gitdir = {
        interval = 5000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
      },
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    },
  },
  -- Git commands
  { "tpope/vim-fugitive", event = "BufRead" },
  -- global TODO list
  {
    "arnarg/todotxt.nvim",
    cmd = { "ToDoTxtCapture", "ToDoTxtTasksToggle" },
    -- "ToggleTermSendCurrentLine
    -- ToggleTermSetName,
    -- ToDoTxtTasksClose,
    -- ToggleStripWhitespaceOnSave,
    -- ToggleTermSendVisualLines,
    -- ToggleTermToggleAll,
    -- ToDoTxtTasksOpen,
    config = function()
      require("todotxt-nvim").setup {
        todo_file = "~/notes/todo.txt",
        -- Keymap used in sidebar split
        keymap = {
          quit = "q",
          toggle_metadata = "m",
          delete_task = "dd",
          complete_task = "<space>",
          edit_task = "ee",
        },
      }
    end,
  },
}
