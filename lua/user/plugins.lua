local fn = vim.fn

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- the best leader key
vim.g.mapleader = " "
require("lazy").setup({
  spec = {
    { "folke/lazy.nvim",                             tag = "stable" },
    { "nvim-lua/plenary.nvim", }, -- Useful lua functions used by lots of plugins

    { "windwp/nvim-autopairs", }, -- Autopairs, integrates with both cmp and treesitter
    { "numToStr/Comment.nvim", },
    -- { "JoosepAlviste/nvim-ts-context-commentstring", },
    { "kyazdani42/nvim-web-devicons", },
    { "kyazdani42/nvim-tree.lua", },
    { "akinsho/bufferline.nvim", },
    { "moll/vim-bbye", },
    {
      "nvim-lualine/lualine.nvim",
      opts = {
        options = { theme = "gruvbox-material", icons_enabled = true }
      }
    },
    {
      "ap/vim-css-color",
      ft = { "css", "scss", "less", "sass", "stylus" }
    },
    -- respect editorconfig files
    { "editorconfig/editorconfig-vim" },
    -- manage and replace quotes, brackets, parens, etc
    { "tpope/vim-surround" },
    -- commenting motions
    -- { "tpope/vim-commentary" },
    -- nuke whitespace
    { "ntpeters/vim-better-whitespace" },
    -- sorting as a motion
    { "christoomey/vim-sort-motion" },

    -- breadcrumbs
    {
      "SmiteshP/nvim-navic",
      event = "User FileOpened",
    },
    { "akinsho/toggleterm.nvim", },
    { "ahmedkhalf/project.nvim", },
    { "lewis6991/impatient.nvim", },
    { "lukas-reineke/indent-blankline.nvim", },
    { "goolord/alpha-nvim", },

    -- Colorschemes,
    {
      "sainnhe/gruvbox-material",
      config = function()
        vim.g.gruvbox_material_foreground = "original"
        vim.g.gruvbox_material_background = "medium"
        vim.g.gruvbox_material_better_performance = 1
        vim.cmd("colorscheme gruvbox-material")
      end,
    },

    -- cmp plugins,
    { "hrsh7th/nvim-cmp", },         -- The completion plugin,
    { "hrsh7th/cmp-buffer", },       -- buffer completions,
    { "hrsh7th/cmp-path", },         -- path completions,
    { "saadparwaiz1/cmp_luasnip", }, -- snippet completions,
    { "hrsh7th/cmp-nvim-lsp", },
    { "hrsh7th/cmp-nvim-lua", },
	  { "github/copilot.vim", event = { "InsertEnter"} },

    -- snippets,
    { "L3MON4D3/LuaSnip", },             --snippet engine,
    { "rafamadriz/friendly-snippets", }, -- a bunch of snippets to use

    -- LSP
    -- ,{ "williamboman/nvim-lsp-installer", } -- simple to use language server installer,
    { "neovim/nvim-lspconfig", }, -- enable LSP,
    { "williamboman/mason.nvim", },
    { "williamboman/mason-lspconfig.nvim", },
    { "jose-elias-alvarez/null-ls.nvim", }, -- for formatters and linters
    { "RRethy/vim-illuminate", },

    -- Telescope,
    { "nvim-telescope/telescope.nvim", },

    -- Treesitter,
    {
      "nvim-treesitter/nvim-treesitter",

    },

    -- Git
    { "lewis6991/gitsigns.nvim", },

    -- DAP,
    { "mfussenegger/nvim-dap", },
    { "rcarriga/nvim-dap-ui", },
    { "ravenxrz/DAPInstall.nvim", },

    {
      "alexghergh/nvim-tmux-navigation",
      opts = {
        disable_when_zoomed = true, -- defaults to false
      }
    },
    -- lsp progress inidicator
    { "j-hui/fidget.nvim"  },
    -- unobstrusive notifier
    {
      "vigoux/notifier.nvim",
      opts = {
        components = {  -- Order of the components to draw from top to bottom (first nvim notifications, then lsp)
          "nvim",  -- Nvim notifications (vim.notify and such)
          "lsp"  -- LSP status updates
        },
      },
    },

  },
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
  },
  install = { colorscheme = { "gruvbox-material" } },
  checker = { enabled = true }, -- automatically check for plugin updates
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
})
