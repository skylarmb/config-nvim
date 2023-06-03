---------- Editor ----------
return {
  -- quote/bracket and surround motions
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },
  -- Autopairs, integrates with both cmp and treesitter
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    dependencies = { "hrsh7th/nvim-cmp" },
    opts = {
      check_ts = true, -- treesitter integration
      disable_filetype = { "TelescopePrompt" },
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({}))
    end,
  },
  -- respect editorconfig files
  { "editorconfig/editorconfig-vim", lazy = false },
  -- nuke whitespace
  { "ntpeters/vim-better-whitespace", lazy = false },
  -- sorting as a motion
  { "christoomey/vim-sort-motion", event = "VeryLazy" },
  -- snippets and clipboard
  {
    "AckslD/nvim-neoclip.lua",
    enaled = false,
    event = "VeryLazy",
    dependencies = { "kkharji/sqlite.lua", module = "sqlite" },
    opts = {
      enable_persistent_history = true, -- persist clipboard between sessions
    },
  },
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
      { "twilight.nvim" },
    },
  },
  -- dynamic identation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
    config = function()
      require("indent_blankline").setup({
        -- char = "▏",
        -- char = "│",
        -- char = " ▏ │ ▏ ▏",
        show_trailing_blankline_indent = false,
        show_first_indent_level = true,
        use_treesitter = true,
        show_current_context = true,
        buftype_exclude = { "terminal", "nofile", "help" },
        filetype_exclude = {
          "help",
          "packer",
          "NvimTree",
        },
      })
    end,
  },
  -- treesitter-aware commenting that works with TSX
  {
    "numToStr/Comment.nvim",
    event = { "VeryLazy" },
    opts = {
      pre_hook = function(ctx)
        -- Only calculate commentstring for tsx filetypes
        if vim.bo.filetype == "typescriptreact" then
          local U = require("Comment.utils")

          -- Determine whether to use linewise or blockwise commentstring
          local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

          -- Determine the location where to calculate commentstring from
          local location = nil
          if ctx.ctype == U.ctype.blockwise then
            location = require("ts_context_commentstring.utils").get_cursor_location()
          elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require("ts_context_commentstring.utils").get_visual_start_location()
          end

          return require("ts_context_commentstring.internal").calculate_commentstring({
            key = type,
            location = location,
          })
        end
      end,
    },
  },
}
