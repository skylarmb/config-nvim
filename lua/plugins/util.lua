return {
  -- automatic session management
  -- { "tpope/vim-obsession" },
  -- debug logging in separate buffer
  { "vim-scripts/Decho" },
  -- repl / debugger
  {
    "tpope/vim-scriptease",
    event = "VeryLazy",
    ft = { "lua", "viml" },
    cmd = { "PP", "Messages" },
  },
  -- Bdelete!
  { "moll/vim-bbye", lazy = false },
  -- seamless jumping between tmux panes and buffers
  {
    "alexghergh/nvim-tmux-navigation",
    opts = {
      disable_when_zoomed = true, -- defaults to false
    },
  },
  -- floating term
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-t>]],
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
        },
      })

      function _G.set_terminal_keymaps()
        local opts = { noremap = true }
        -- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
      end

      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end
      vim.keymap.set("n", "<leader>gg", "", { remap = false, silent = true, callback = _LAZYGIT_TOGGLE })
    end,
  },
  -- global TODO list
  {
    "arnarg/todotxt.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = { "ToDoTxtCapture", "ToDoTxtTasksToggle" },
    -- "ToggleTermSendCurrentLine
    -- ToggleTermSetName,
    -- ToDoTxtTasksClose,
    -- ToggleStripWhitespaceOnSave,
    -- ToggleTermSendVisualLines,
    -- ToggleTermToggleAll,
    -- ToDoTxtTasksOpen,
    config = function()
      require("todotxt-nvim").setup({
        todo_file = "~/notes/todo.txt",
        -- Keymap used in sidebar split
        keymap = {
          quit = "q",
          toggle_metadata = "m",
          delete_task = "dd",
          complete_task = "<space>",
          edit_task = "ee",
        },
      })
    end,
  },
}