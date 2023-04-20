local fn = vim.fn

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- the best leader key
vim.g.mapleader = " "
require("lazy").setup {
  spec = {
    { "folke/lazy.nvim" },
    { "tpope/vim-scriptease" },

    { import = "user.plugin" },

    { "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins

    { "windwp/nvim-autopairs" }, -- Autopairs, integrates with both cmp and treesitter
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    { "kyazdani42/nvim-web-devicons" },
    { "kyazdani42/nvim-tree.lua" },
    { "akinsho/bufferline.nvim" },
    { "moll/vim-bbye" },
    {
      "nvim-lualine/lualine.nvim",
      opts = {
        options = { theme = "gruvbox-material", icons_enabled = true },
      },
    },
    {
      "ap/vim-css-color",
      ft = { "css", "scss", "less", "sass", "stylus" },
    },
    -- respect editorconfig files
    { "editorconfig/editorconfig-vim", event = "VeryLazy" },
    -- manage and replace quotes, brackets, parens, etc
    { "tpope/vim-surround", event = "VeryLazy" },
    -- commenting motions
    -- { "tpope/vim-commentary" },
    -- nuke whitespace
    { "ntpeters/vim-better-whitespace", event = "VeryLazy" },
    -- sorting as a motion
    { "christoomey/vim-sort-motion", event = "VeryLazy" },

    -- breadcrumbs
    {
      "SmiteshP/nvim-navic",
      event = "User FileOpened",
    },
    { "akinsho/toggleterm.nvim" },
    { "ahmedkhalf/project.nvim" },
    { "lewis6991/impatient.nvim" },
    { "lukas-reineke/indent-blankline.nvim" },

    -- Colorschemes,
    {
      "sainnhe/gruvbox-material",
      config = function()
        vim.g.gruvbox_material_foreground = "mixed"
        vim.g.gruvbox_material_background = "medium"
        vim.g.gruvbox_material_better_performance = 1
        vim.cmd "colorscheme gruvbox-material"
      end,
    },
    { "norcalli/nvim-colorizer.lua" },

    -- -- cmp plugins,
    -- { "hrsh7th/nvim-cmp" }, -- The completion plugin,
    -- { "hrsh7th/cmp-buffer" }, -- buffer completions,
    -- { "hrsh7th/cmp-path" }, -- path completions,
    -- { "saadparwaiz1/cmp_luasnip" }, -- snippet completions,
    -- { "hrsh7th/cmp-nvim-lsp" },
    -- { "hrsh7th/cmp-nvim-lua" },
    -- { "hrsh7th/cmp-nvim-lsp-signature-help" },
    -- -- { "github/copilot.vim", event = { "InsertEnter" } },
    --
    -- -- snippets,
    -- { "L3MON4D3/LuaSnip" }, --snippet engine,
    -- { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use
    --
    -- -- LSP
    -- -- ,{ "williamboman/nvim-lsp-installer", } -- simple to use language server installer,
    -- { "neovim/nvim-lspconfig" }, -- enable LSP,
    -- { "williamboman/mason.nvim" },
    -- { "williamboman/mason-lspconfig.nvim" },
    -- { "jose-elias-alvarez/null-ls.nvim" }, -- for formatters and linters
    -- { "RRethy/vim-illuminate" },
    {
      "VonHeikemen/lsp-zero.nvim",
      branch = "v2.x",
      dependencies = {
        -- LSP Support
        { "neovim/nvim-lspconfig" }, -- Required
        { -- Optional
          "williamboman/mason.nvim",
          build = function()
            pcall(vim.cmd, "MasonUpdate")
          end,
        },
        { "williamboman/mason-lspconfig.nvim" }, -- Optional

        -- Autocompletion
        { "hrsh7th/nvim-cmp" }, -- Required
        { "hrsh7th/cmp-nvim-lsp" }, -- Required
        { "L3MON4D3/LuaSnip" }, -- Required
      },
    },
    -- Telescope,
    { "folke/persistence.nvim" },
    { "stevearc/dressing.nvim", event = "VeryLazy" },
    {
      "CosmicNvim/cosmic-ui",
      dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
      config = function()
        require("cosmic-ui").setup()
      end,
    },
    { "folke/trouble.nvim" },
    {
      "rmagatti/goto-preview",
      dependencies = { "CosmicNvim/cosmic-ui" },
      config = function()
        require("goto-preview").setup {
          width = 80, -- Width of the floating window
          height = 15, -- Height of the floating window
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- Border characters of the floating window
          default_mappings = false, -- Bind default mappings
          debug = false, -- Print debug information
          opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
          resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
          post_open_hook = nil, -- A
          references = { -- Configure the telescope UI for slowing the references cycling window.
            telescope = require("telescope.themes").get_dropdown { hide_preview = false },
          },
          -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
          focus_on_open = false, -- Focus the floating window when opening it.
          dismiss_on_move = true, -- Dismiss the floating window when moving the cursor.
          force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
          bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
          stack_floating_preview_windows = false, -- Whether to nest floating windows
          preview_window_title = { enable = false }, -- Whether to set
        }
      end,
    },
    --
    -- Treesitter,
    {
      "nvim-treesitter/nvim-treesitter",
    },

    { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
    -- Git
    { "lewis6991/gitsigns.nvim" },
    { "tpope/vim-fugitive" },

    -- DAP,
    { "mfussenegger/nvim-dap" },
    { "rcarriga/nvim-dap-ui" },
    { "ravenxrz/DAPInstall.nvim" },

    {
      "alexghergh/nvim-tmux-navigation",
      opts = {
        disable_when_zoomed = true, -- defaults to false
      },
    },
    -- lsp progress inidicator
    { "j-hui/fidget.nvim" },
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
    -- quickfix / search
    { "kevinhwang91/nvim-bqf" },
    { "rking/ag.vim" },
    -- text / writing
    { "folke/twilight.nvim" },
    {
      "Pocco81/true-zen.nvim",
      opts = {
        integrations = {
          twilight = true, -- enable twilight (ataraxis)
          lualine = true, -- hide nvim-lualine (ataraxis)
        },
      },
    },
  },
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
  },
  install = { colorscheme = { "gruvbox-material" } },
  checker = { enabled = false }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}
