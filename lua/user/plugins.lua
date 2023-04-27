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

-- the best leader key
require("lazy").setup({
  { "folke/lazy.nvim" },
  { import = "user.plugin" },
}, {
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
  },
  install = { colorscheme = { "gruvbox-material" } },
  checker = {
    enabled = true,
    concurrency = 1, -- set to 1 to check for updates very slowly
    notify = true, -- get a notification when new updates are found
    frequency = 60 * 60 * 24, -- check for updates once a day
  },
  change_detection = {
    enabled = true,
    notify = false, -- dont notify when config files change
  },
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
