local default_opts = { silent = true, noremap = true }
local remap_opts = { silent = true, remap = true }

local function keymap(m, k, c, o)
  local opts = o or default_opts
  vim.keymap.set(m, k, c, opts)
end

-- Config --

keymap("n", "<S-l>", ":bnext<CR>")
-- Navigate buffers
keymap("n", "<S-h>", ":bprevious<CR>")

-- Clear highlights
keymap("n", "<leader><leader>", "<cmd>nohlsearch<CR>")

-- Better paste
keymap("v", "p", '"_dP')

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>")

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Plugins --

-- NvimTree
keymap("n", "`", ":NvimTreeFindFileToggle<CR>")

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>")

-- Comment
-- keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>")
-- keymap("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>")
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>")
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>")
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>")
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>")
keymap("n", ";", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>")

-- LSP
keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>")
keymap("n", "<leader>li", "<cmd>LspInfo<cr>")
keymap("n", "<leader>lI", "<cmd>Mason<cr>")
keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>")
keymap("n", "ge", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>")
keymap("n", "gp", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>")
keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>")
keymap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
keymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>")
keymap("n", "rn", "<cmd>lua require('cosmic-ui').rename()<CR>")
keymap("n", "ga", '<cmd>lua require("cosmic-ui").code_actions()<cr>')
keymap("v", "ga", '<cmd>lua require("cosmic-ui").range_code_actions()<cr>')
keymap("n", "gf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>")

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
-- exit insert for term mode
keymap("t", "jj", "<C-\\><C-n>")
keymap("t", "jk", "<C-\\><C-n>")
keymap("t", "<ESC>", "<C-\\><C-n>")
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
keymap("n", "ww", "<cmd>w<cr>")
-- yank current file name and line number
keymap("n", "yl", ":let @*=expand('%') . ':' . line('.')<CR>")
-- yank current file name
keymap("n", "yn", ":let @*=expand('%')<CR>")
-- show current yank rink
-- keymap("n", "<C-y>", ":YRShow<CR>")
-- dupe line
-- keymap("n", "<C-d>", "yyp")
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
keymap("n", "<C-b>", ":Telescope buffers<CR>")
keymap("n", "<leader>w", ":Telescope workspaces<cr>")
keymap("n", "<c-f>", "<cmd>Telescope live_grep<CR>")
keymap("n", "<leader>th", "<cmd>Telescope highlights<CR>")

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
keymap("n", "<leader>m", ":NotifierReplay<CR>")

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
-- change vim working dir to current buffer dir
keymap("n", "<leader>cdf", ":cd %:h<CR>")
-- change vim working dir to current buffer parent dir
keymap("n", "<leader>cdu", ":cd %:p<CR>")
-- recently edited files
keymap("n", "z", "<cmd>Telescope oldfiles<cr>")
-- file tree
keymap("n", "`", "<cmd>NvimTreeFindFileToggle<cr>")
-- sidebar
keymap("n", "<leader>`", "<cmd>SidebarNvimToggle<cr>")

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
keymap("n", "<leader>t", "<cmd>TroubleToggle workspace_diagnostics<CR>")
keymap("n", "<D-s>", ":w<CR>") -- Save
keymap("v", "<D-c>", '"+y') -- Copy
keymap("n", "<D-v>", '"+P') -- Paste normal mode
keymap("v", "<D-v>", '"+P') -- Paste visual mode
keymap("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert modeend
keymap("n", "<leader>tt", "<cmd>ToDoTxtTasksToggle<CR>") -- TODO list
keymap("n", "<leader>tn", "<cmd>ToDoTxtCapture<CR>") -- TODO list

------------ Command & Term mode ------------
-- expand %% to current dir name
keymap("c", "%%", "<C-R>=expand('%:h').'/'<CR>")
-- GUI vim client paste command mode
keymap("c", "<D-v>", "<C-R>+")
-- disable annoying default bind
keymap("c", "<C-f>", "")
-- get me out of here!
keymap("c", "<ESC>", "<C-c>")
-- open floating term
keymap("n", "<C-t>", "<cmd>ToggleTerm<cr><insert>")
