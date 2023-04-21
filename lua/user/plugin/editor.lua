---------- Editor ----------
return {
  -- quote/bracket and surround motions
  { "tpope/vim-surround", event = "VeryLazy" },
  -- Autopairs, integrates with both cmp and treesitter
  { "windwp/nvim-autopairs", event = "VeryLazy" },
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  -- respect editorconfig files
  { "editorconfig/editorconfig-vim", event = "VeryLazy" },
  -- nuke whitespace
  { "ntpeters/vim-better-whitespace", event = "VeryLazy" },
  -- sorting as a motion
  { "christoomey/vim-sort-motion", event = "VeryLazy" },
  -- Distraction-free editing
  {
    "Pocco81/true-zen.nvim",
    cmd = "TZAtaraxis",
    opts = {
      integrations = {
        twilight = true, -- enable twilight (ataraxis)
        lualine = true, -- hide nvim-lualine (ataraxis)
      },
    },
    dependencies = {
      { "folke/twilight.nvim" },
    },
  },
  -- dynamic identation guides
  { "lukas-reineke/indent-blankline.nvim" },
  -- treesitter-aware commenting that works with TSX
  {
    "numToStr/Comment.nvim",
    opts = {
      pre_hook = function(ctx)
        -- Only calculate commentstring for tsx filetypes
        if vim.bo.filetype == "typescriptreact" then
          local U = require "Comment.utils"

          -- Determine whether to use linewise or blockwise commentstring
          local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

          -- Determine the location where to calculate commentstring from
          local location = nil
          if ctx.ctype == U.ctype.blockwise then
            location = require("ts_context_commentstring.utils").get_cursor_location()
          elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require("ts_context_commentstring.utils").get_visual_start_location()
          end

          return require("ts_context_commentstring.internal").calculate_commentstring {
            key = type,
            location = location,
          }
        end
      end,
    },
  },
}
