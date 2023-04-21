-- set working dir for Telescope
-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--   callback = function()
--     vim.cmd "set verbose=0"
--   end,
-- })

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyInstall",
  once = true,
  callback = function()
    vim.cmd("helptags ALL")
    vim.notify("Regenerated helptags!")
  end,
})

vim.api.nvim_create_user_command("FindFiles", function()
  require("telescope.builtin").find_files { cwd = vim.loop.cwd() }
end, {})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd "silent! cd %:p:h"
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf" },
  callback = function()
    vim.cmd "setlocal nonumber colorcolumn="
    vim.keymap.set("n", "qq", "<cmd>cclose<CR>", { noremap = true, silent = true, buffer = true })
    vim.keymap.set("n", "q", "<cmd>cclose<CR>", { noremap = true, silent = true, buffer = true })
  end,
})


-- help window in new split
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "help",
  callback = function()
    vim.cmd "wincmd L"
    vim.keymap.set("n", "q", "<cmd>close<CR>", { noremap = true, silent = true, buffer = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- -- Automatically close tab/vim when nvim-tree is the last window in the tab
-- vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd "StripWhitespace"
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.java" },
  callback = function()
    vim.lsp.codelens.refresh()
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd "hi link illuminatedWord LspReferenceText"
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    local line_count = vim.api.nvim_buf_line_count(0)
    if line_count >= 5000 then
      vim.cmd "IlluminatePauseBuf"
    end
  end,
})

-- close unused buffers
local id = vim.api.nvim_create_augroup("startup", {
  clear = false,
})
local persistbuffer = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  vim.fn.setbufvar(bufnr, "bufpersist", 1)
end
vim.api.nvim_create_autocmd({ "BufRead" }, {
  group = id,
  pattern = { "*" },
  callback = function()
    vim.api.nvim_create_autocmd({ "InsertEnter", "BufModifiedSet" }, {
      buffer = 0,
      once = true,
      callback = function()
        persistbuffer()
      end,
    })
  end,
})
vim.keymap.set("n", "<Leader>b", function()
  local curbufnr = vim.api.nvim_get_current_buf()
  local buflist = vim.api.nvim_list_bufs()
  for _, bufnr in ipairs(buflist) do
    if vim.bo[bufnr].buflisted and bufnr ~= curbufnr and (vim.fn.getbufvar(bufnr, "bufpersist") ~= 1) then
      vim.cmd("bd " .. tostring(bufnr))
    end
  end
end, { silent = true, desc = "Close unused buffers" })

-- Alpha when no buffers
-- local function get_listed_buffers()
--   local buffers = {}
--   local len = 0
--   for buffer = 1, vim.fn.bufnr "$" do
--     if vim.fn.buflisted(buffer) == 1 then
--       len = len + 1
--       buffers[len] = buffer
--     end
--   end
--
--   return buffers
-- end
--
-- vim.api.nvim_create_augroup("alpha_on_empty", { clear = true })

-- vim.api.nvim_create_autocmd("User", {
--   pattern = "BDeletePre",
--   group = "alpha_on_empty",
--   callback = function(event)
--     local found_non_empty_buffer = false
--     local buffers = get_listed_buffers()
--
--     for _, bufnr in ipairs(buffers) do
--       if not found_non_empty_buffer then
--         local name = vim.api.nvim_buf_get_name(bufnr)
--         local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
--
--         if bufnr ~= event.buf and name ~= "" and ft ~= "Alpha" then
--           found_non_empty_buffer = true
--         end
--       end
--     end
--
--     if not found_non_empty_buffer then
--       vim.cmd [[:Alpha]]
--     end
--   end,
-- })

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "Alpha" },
  callback = function()
    vim.keymap.set("n", "q", "", { noremap = true, silent = true, buffer = true })
    vim.keymap.set("n", "qq", "", { noremap = true, silent = true, buffer = true })
  end,
})

-- " Goyo / Limelight
-- let g:limelight_conceal_ctermfg = 'gray'
-- let g:limelight_default_coefficient = 0.7
-- let g:limelight_paragraph_span = 1
--
-- autocmd! User GoyoEnter call OnGoyoEnter()
-- autocmd! User GoyoLeave call OnGoyoLeave()
--
-- " text editing settings: limelight, text width, word wrap, and spell check
-- function OnGoyoEnter()
--   Limelight
--   " setlocal tw=80
--   " setlocal fo+=a
--   setlocal spell
--   setlocal scrolloff
-- endfunction
--
-- " disable text editing settings
-- function OnGoyoLeave()
--   Limelight!
--   " setlocal tw&
--   " setlocal fo-=a
--   setlocal nospell
--   setlocal scroll
-- endfunction
--
--
