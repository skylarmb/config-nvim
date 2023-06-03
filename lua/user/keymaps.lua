local default_opts = { silent = true, remap = false }
local remap_opts = { silent = true, remap = true }
local expand = vim.fn.expand

local cword = "<C-R>=expand('<cword>')<CR>"
local cexpr = "<C-R>=expand('<cexpr>')<CR>"

local function cmd(...)
  local s = table.concat({ ... }, " ")
  local pk = string.sub(s, 1, 1) == ":" and ":" or "<cmd>"
  return pk .. s .. "<cr>"
end

local function keymap(m, k, c, o)
  local opts = o or default_opts
  vim.keymap.set(m, k, c, opts)
end
local nvx = { "n", "v", "x" }

-- Config --

keymap("n", "<S-l>", "<cmd>bnext<CR>")
-- Navigate buffers
keymap("n", "<S-h>", "<cmd>bprevious<CR>")

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
keymap("n", "`", "<cmd>NvimTreeFindFileToggle<CR>")

-- Comment
-- keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>")
-- keymap("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

-- DAP
keymap("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end)
keymap("n", "<leader>dc", function()
  require("dap").continue()
end)
keymap("n", "<leader>di", function()
  require("dap").step_into()
end)
keymap("n", "<leader>do", function()
  require("dap").step_over()
end)
keymap("n", "<leader>dO", function()
  require("dap").step_out()
end)
keymap("n", "<leader>dr", function()
  require("dap").repl.toggle()
end)
keymap("n", "<leader>dl", function()
  require("dap").run_last()
end)
keymap("n", "<leader>du", function()
  require("dapui").toggle()
end)
keymap("n", "<leader>dt", function()
  require("dap").terminate()
end)
keymap("n", ";", function()
  require("goto-preview").goto_preview_definition()
end)

-- LSP
keymap("n", "gi", function()
  vim.lsp.buf.declaration()
end)
keymap("n", "gD", function()
  vim.lsp.buf.definition()
end)
-- go to source implementation if possible
keymap("n", "gd", function()
  require("typescript").goToSourceDefinition(vim.fn.win_getid(), { fallback = true })
end)
keymap("n", "gr", function()
  vim.lsp.buf.references()
end)
keymap("n", "gr", function()
  vim.lsp.buf.references()
end)
keymap("n", "gl", function()
  vim.diagnostic.open_float()
end)
keymap("n", "<leader>li", "<cmd>LspInfo<cr>")
keymap("n", "<leader>lI", "<cmd>Mason<cr>")
keymap("n", "<leader>la", function()
  vim.lsp.buf.code_action()
end)
keymap("n", "ge", function()
  vim.diagnostic.goto_next({ buffer = 0 })
end)
keymap("n", "gp", function()
  vim.diagnostic.goto_prev({ buffer = 0 })
end)
keymap("n", "<leader>lr", function()
  vim.lsp.buf.rename()
end)
keymap("n", "<leader>ls", function()
  vim.lsp.buf.signature_help()
end)
keymap("n", "<leader>lq", function()
  vim.diagnostic.setloclist()
end)
keymap("n", "rn", function()
  require("cosmic-ui").rename()
end)
keymap("n", "ga", function()
  require("cosmic-ui").code_actions()
end)
keymap("v", "ga", function()
  require("cosmic-ui").range_code_actions()
end)
keymap("n", "gf", function()
  local typescript = require("typescript")
  typescript.actions.addMissingImports()
  typescript.actions.removeUnused()
  typescript.actions.fixAll()
  vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
end)
keymap("n", "<leader>t", cmd("TroubleToggle workspace_diagnostics"))

------------ Movement ------------
-- always move by display lines when wrapping
keymap(nvx, "k", "gk", remap_opts)
keymap(nvx, "j", "gj", remap_opts)
-- jump 10 lines
keymap(nvx, "K", "10gk", remap_opts)
keymap(nvx, "J", "10gj", remap_opts)
-- beginning / end of line
keymap(nvx, "H", "^", remap_opts)
keymap(nvx, "L", "$l", remap_opts)
-- move by beginning of word instead of end of word
keymap(nvx, "E", "b", remap_opts)
keymap(nvx, "e", "w", remap_opts)
-- exit insert mode with jk
keymap("i", "jk", "<ESC>l")
keymap("i", "jj", "<ESC>l")
keymap("i", "JJ", "<ESC>l")
keymap("i", "KK", "<ESC>l")
-- exit insert for term mode
-- keymap("t", "jj", "<C-\\><C-n>")
keymap("t", "jk", "<C-\\><C-n>")
keymap("t", "<ESC>", "<C-\\><C-n>")
-- enter insert mode when pressing backspace from normal mode
keymap(nvx, "<bs>", "i<bs>")
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
keymap("n", "qd", "m'<cmd>Bdelete!<CR>")
keymap("n", "qa", "m'<cmd>wqa<CR>")
-- rebind macro recording to not conflict with qq
keymap("n", "q", "")
keymap("n", "<leader>q", "q")
-- ww to write from normal mode
keymap("n", "ww", "<cmd>w<cr>")
-- yank current file name and line number
keymap("n", "yl", "<cmd>let @*=expand('%') . ':' . line('.')<CR>")
-- yank current file name
keymap("n", "yn", "<cmd>let @*=expand('%')<CR>")
-- show current yank rink
keymap("n", "<C-y>", "<cmd>YRShow<CR>")
-- dupe line
keymap(nvx, "<C-d>", "yyp")
keymap(nvx, "0", '"0y')
keymap(nvx, ")", '"0p')
-- join visual selection
keymap("x", "<leader>j", cmd("'<,'>join"))
-- browse source of current file
keymap(
  "n",
  "<leader>gs",
  [[:silent !/bin/zsh -i -c 'browsesource "$(basename `git rev-parse --show-toplevel`)" %'<CR>]]
)

-- move lines up and down
keymap("n", "<c-n>", "<cmd>m +1<CR>")
keymap("n", "<c-m>", "<cmd>m -2<CR>")
keymap("v", "<c-n>", "<cmd>m '>+1<CR>gv=gv")
keymap("v", "<c-m>", "<cmd>m '<-2<CR>gv=gv")
-- toggle wrap
-- keymap("n", "<leader>w", ":set wrap!<CR>")
-- indentation
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")
-- clean whitespace
keymap("n", "<leader>W", "<cmd>StripWhitespace<CR>")

------------ Search ------------
keymap("n", "<C-p>", "<cmd>Telescope find_files<cr>")
keymap("n", "<C-b>", "<cmd>Telescope buffers<CR>")
keymap("n", "<c-f>", "<cmd>Telescope live_grep<CR>")
keymap("n", "<leader>s", "/\\%V", { silent = false })
keymap("n", "<leader>th", "<cmd>Telescope highlights<CR>")
keymap("n", "<leader>o", "<cmd>Telescope jumplist<CR>")
keymap("n", "<leader>m", "<cmd>Telescope marks<CR>")
-- keymap("n", "<leader>c", ":%sno//g<LEFT><LEFT>", { silent = false }) -- replace word under cursor
-- jump back to last insert location. `I` mark is set in autocmds.lua
keymap("n", "<leader>i", "'I")
-- recently edited files
keymap("n", "<leader>z", "<cmd>Telescope oldfiles<cr>")
-- jump to project roots via detection of package.json, .git, etc
keymap("n", "<leader>w", "<cmd>Telescope projects<cr>")
-- re-open picker
keymap("n", "<leader>p", "<cmd>Telescope resume<cr>")

-- buffer search word under cursor
keymap("n", "f", "*N")
-- non-recursive . motion
keymap("n", ",", ".n")
-- Ack / ripgrep
keymap("n", "F", ":Ack! " .. cword .. "<cr>", { silent = false })
keymap("n", "<leader>f", ":Ack ", { silent = false, remap = true })
keymap("n", "<leader>s", ":Acks /" .. expand("%s") .. "//<left><left>", { silent = false })
-- ack lines in listed buffers
keymap("n", "<leader>l", ":Back ")
-- help
keymap("n", "<leader>hw", cmd(":help ", cword))
keymap("n", "<leader>hh", cmd(":help ", cexpr))
-- replay notifications on to quickfix list
keymap("n", "<leader>m", "<cmd>NotifierReplay<CR><cmd>Bufferize messages<CR>")

------------ Tabs and Splits ------------
-- new vertical split
keymap("n", "<leader>vs", "<C-w><C-v>")
-- new horizontal split
keymap("n", "<leader>hs", "<C-w><C-s>")
-- resize splits by 10 columns
keymap("n", "<leader>,", "<c-w>10><CR>")
keymap("n", "<leader>.", "<c-w>10<<CR>")
keymap("n", "[", "<cmd>tabprev<cr>")
keymap("n", "]", "<cmd>tabnext<cr>")
keymap("n", "<M-1>", "1gt<CR>")
keymap("n", "<M-2>", "2gt")

------------ File browsing ------------
keymap("n", "<leader>n", "<cmd>n<CR>")
-- file tree
keymap("n", "`", "<cmd>NvimTreeFindFileToggle<cr>")
-- sidebar
keymap("n", "<leader>`", "<cmd>SidebarNvimToggle<cr>")

------------ Git ------------
-- git mergetool
keymap("n", "mt", "<cmd>MergetoolToggle<CR>")
keymap("n", "mgr", "<cmd>MergetoolDiffExchangeLeft<CR>")
keymap("n", "mgl", "<cmd>MergetoolDiffExchangeRight<CR>")
keymap("n", "<leader>gd", "<cmd>Gdiff<CR>")

------------ Misc ------------
keymap("n", "<D-s>", "<cmd>w<CR>") -- Save
keymap("v", "<D-c>", '"+y') -- Copy
keymap("n", "<D-v>", '"+P') -- Paste normal mode
keymap("v", "<D-v>", '"+P') -- Paste visual mode
keymap("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert modeend
keymap("n", "<leader>tt", "<cmd>ToDoTxtTasksToggle<CR>") -- TODO list
keymap("n", "<leader>tn", "<cmd>ToDoTxtCapture<CR>") -- TODO list
keymap("n", "<leader>a", "cs\"'", remap_opts) -- change quotes
keymap("n", "<leader>s", "cs'\"", remap_opts) -- change quotes

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
