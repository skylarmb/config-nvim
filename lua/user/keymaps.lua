-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true, noremap = true }
local remap_opts = { silent = true, remap = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Config --

keymap("n", "<S-l>", ":bnext<CR>", opts)
-- Navigate buffers
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader><leader>", "<cmd>nohlsearch<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

-- NvimTree
keymap("n", "`", ":NvimTreeFindFileToggle<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
-- keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
-- keymap("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)
keymap("n", ";", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", opts)

-- LSP
keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
keymap("n", "<leader>lI", "<cmd>Mason<cr>", opts)
keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
keymap("n", "ge", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
keymap("n", "gp", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
keymap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
keymap("n", "rn", "<cmd>lua require('cosmic-ui').rename()<CR>", opts)
keymap("n", "ga", '<cmd>lua require("cosmic-ui").code_actions()<cr>')
keymap("v", "ga", '<cmd>lua require("cosmic-ui").range_code_actions()<cr>', opts)
keymap("n", "gf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)

local nvx = { "n", "v", "x" }

------------ Movement ------------
-- always move by display lines when wrapping
keymap(nvx, "k", "gk", remap_opts)
keymap(nvx, "j", "gj", remap_opts)
-- jump 10 lines
keymap(nvx, "K", "10k", remap_opts)
keymap(nvx, "J", "10j", remap_opts)
-- beginning / end of line
keymap(nvx, "H", "^", remap_opts)
keymap(nvx, "L", "$l", remap_opts)
-- move by beginning of word instead of end of word
keymap(nvx, "E", "b", remap_opts)
keymap(nvx, "e", "w", remap_opts)
-- exit insert mode with jj/jk
keymap("i", "jj", "<ESC>l")
keymap("i", "jk", "<ESC>l")
-- jj for term mode
keymap("t", "jj", "<C-\\><C-n>")
-- enter insert mode when pressing backspace from normal mode
keymap("n", "<bs>", "i<bs>")
-- bounce between brackets
keymap("n", "t", "%")
keymap("v", "t", "%")
-- seamless tmux navigation

keymap("n", "<C-h>", "<cmd>NvimTmuxNavigateLeft<cr>")
keymap("n", "<C-j>", "<cmd>NvimTmuxNavigateDown<cr>")
keymap("n", "<C-k>", "<cmd>NvimTmuxNavigateUp<cr>")
keymap("n", "<C-l>", "<cmd>NvimTmuxNavigateRight<cr>")

------------ Editing ------------

-- redo with U
keymap("n", "U", "<C-r>")
-- close buffers
keymap("n", "qq", "m'<cmd>close<CR>")
keymap("n", "qa", "m'<cmd>qa<CR>")
-- ww to write from normal mode
keymap("n", "ww", "", {
  callback = function()
    vim.cmd "w"
  end,
})
-- yank current file name and line number
keymap("n", "yl", ":let @*=expand('%') . ':' . line('.')<CR>")
-- yank current file name
keymap("n", "yn", ":let @*=expand('%')<CR>")
-- show current yank rink
keymap("n", "<C-y>", ":YRShow<CR>")
-- dupe line
keymap("n", "<C-d>", "yyp")
-- join visual selection
keymap("x", "<leader>j", ":join<CR>")
-- browse source of current file
keymap(
  "n",
  "<leader>cs",
  [[:silent !/bin/zsh -i -c 'browsesource "$(basename `git rev-parse --show-toplevel`)" %'<CR>]]
)
-- move lines up and down
keymap("n", "<c-n>", ":m +1<CR>")
keymap("n", "<c-m>", ":m -2<CR>")
keymap("v", "<c-n>", ":m '>+1<CR>gv=gv")
keymap("v", "<c-m>", ":m '<-2<CR>gv=gv")
-- toggle wrap
-- keymap("n", "<leader>w", ":set wrap!<CR>")
-- indentation
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")
-- clean whitespace
keymap("n", "<leader>W", ":StripWhitespace<CR>")

------------ Search ------------
keymap("n", "<C-p>", "<cmd>Telescope find_files<cr>")
keymap("n", "<C-b>", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>w", ":Telescope workspaces<cr>")
keymap("n", "<c-f>", "<cmd>Telescope live_grep<CR>")

-- buffer search word under cursor
keymap("n", "f", "*N")
-- ag word under cursor
keymap("n", "F", "<cmd>Ag! <cword><cr>", remap_opts)
-- global live search
-- fzf lines in open buffers
keymap("n", "<leader>l", ":Lines<CR>")
-- help
keymap("n", "<leader>hw", ":help <C-R>=expand('<cword>')<CR><CR>")
keymap("n", "<leader>hh", ":help <C-R>=expand('<cexpr>')<CR><CR>")
keymap("n", "<leader>h", ":help ", { silent = false })
-- replay notifications on to quickfix list
keymap("n", "<leader>m", ":NotifierReplay!<CR>", { noremap = true, silent = true })

------------ Tabs and Splits ------------
-- new vertical split
keymap("n", "<leader>vs", "<C-w><C-v>")
-- new horizontal split
keymap("n", "<leader>hs", "<C-w><C-s>")
-- resize splits by 10 columns
keymap("n", "<leader>,", "<c-w>10><CR>")
keymap("n", "<leader>.", "<c-w>10<<CR>")

------------ File browsing ------------
keymap("n", "<leader>n", ":n<CR>")
-- expand %% to current dir name
keymap("c", "%%", "<C-R>=expand('%:h').'/'<CR>")
-- change vim working dir to current buffer dir
keymap("n", "<leader>cdf", ":cd %:h<CR>")
-- change vim working dir to current buffer parent dir
keymap("n", "<leader>cdu", ":cd %:p<CR>")
-- recently edited files
keymap("n", "z", ":Telescope oldfiles<cr>")
-- file tree
keymap("n", "`", ":NvimTreeFindFileToggle<cr>")

------------ Git ------------
-- change vim working dir to current git root
keymap("n", "<leader>cdg", ":Gcd <CR>")
-- git mergetool
keymap("n", "mt", "<plug>(MergetoolToggle)")
keymap("n", "mgr", ":MergetoolDiffExchangeLeft<CR>")
keymap("n", "mgl", ":MergetoolDiffExchangeRight<CR>")
keymap("n", "<leader>gd", ":Gdiff<CR>")

------------ Misc ------------
-- open Trouble quickfix window
-- keymap("n", "<leader>t", "<cmd>TroubleToggle workspace_diagnostics<CR>")
-- if vim.g.neovide then
vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
vim.keymap.set("v", "<D-c>", '"+y') -- Copy
vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert modeend
-- end
