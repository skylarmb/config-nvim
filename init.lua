vim.g.mapleader = " "

local function safe_require(module)
  local ok, err = pcall(require, module)
  if not ok then
    print("Error loading " .. module .. ": " .. err)
  end
end

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

safe_require "user.options"
safe_require "user.keymaps"
safe_require "user.plugins"
safe_require "user.autocommands"
safe_require "user.cmp"

safe_require "user.treesitter"
safe_require "user.autopairs"

safe_require "user.toggleterm"

safe_require "user.project"
safe_require "user.illuminate"
safe_require "user.indentline"
safe_require "user.dap"
-- safe_require "user.quickfix"
