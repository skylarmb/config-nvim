local function safe_require(module)
  local ok, err = pcall(require, module)
  if not ok then
    print("Error loading " .. module .. ": " .. err)
  end
end

-- set leader before config / plugins
vim.g.mapleader = " "
safe_require("options")

-- lazy load plugins
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

require("lazy").setup({
  { "folke/lazy.nvim" }, -- lazy.nvim can manage itself
  { import = "plugins" },
}, {
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
  },
  dev = {
    path = "~/nvim_dev",
    patterns = { "local" },
  },
  install = { colorscheme = { "gruvbox" } },
  checker = {
    enabled = true,
    concurrency = 1,          -- set to 1 to check for updates very slowly
    notify = true,            -- get a notification when new updates are found
    frequency = 60 * 60 * 24, -- check for updates once a day
  },
  change_detection = {
    enabled = true,
    notify = true,
  },
  performance = {
    rtp = {
      -- disable some rtp plugins that I don't use
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

safe_require("keymaps")
safe_require("autocommands")
