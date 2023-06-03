local ag_opts = "--vimgrep --width 4096 --literal --hidden --follow --ignore-case"

return {
  -- fast searching with :Ag! action
  -- {
  --   "rking/ag.vim",
  --   event = "VeryLazy",
  --   config = function()
  --     vim.g.ag_highlight = 1
  --     vim.g.ag_prg = "ag " .. ag_opts
  --   end
  -- },
  -- structured search and replace
  {
    "cshuaimin/ssr.nvim",
    keys = { "<leader>sr" },
    config = function()
      require("ssr").setup({
        border = "shadow",
        keymaps = {
          close = "q",
          next_match = "<leader>j",
          prev_match = "<leader>k",
          replace_confirm = "<leader>.",
          replace_all = "<leader>a",
        },
      })
    end,
    init = function()
      vim.keymap.set({ "n", "x" }, "<leader>sr", function()
        require("ssr").open()
      end)
    end,
  },
  -- ripgrep multi-file/buffer/quickfix search and replace
  {
    "wincent/ferret",
    cmd = { "Ack", "Back" },
    branch = "main",
    config = function()
      -- vim.g.FerretExecutable = 'ag,rg' -- prefer ag
      vim.g.FerretExecutableArguments = {
        ag = ag_opts,
      }
      vim.g.FerretVeryMagic = 0
    end,
  },
}
