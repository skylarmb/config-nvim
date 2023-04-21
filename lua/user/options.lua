HOME = os.getenv "HOME"
vim.fn.setenv("TERM", "alacritty")

-- vim.cmd "hi NonText cterm=NONE ctermfg=NONE"
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect", "preview" } -- mostly just for cmp
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.history = 9001 -- its over 9000!
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 0 -- always show tabs
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- creates a swapfile
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion (4000ms default)
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.cursorline = true -- highlight the current line
vim.opt.number = true -- set numbered lines
vim.opt.laststatus = 3 -- only the last window will always have a status line
vim.opt.showcmd = false -- hide (partial) command in the last line of the screen (for performance)
vim.opt.numberwidth = 1 -- minimal number of columns to use for the line number {default 4}
vim.opt.signcolumn = "yes:1" -- always show the sign column, otherwise it would shift the text each time
-- vim.opt.wrap = false                            -- display lines as one long line
-- vim.opt.scrolloff = 8                           -- minimal number of screen lines to keep above and below the cursor
-- vim.opt.sidescrolloff = 8                       -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`
-- vim.cmd "highlight Cursor gui=NONE guifg=bg guibg=fg"
-- vim.cmd "hi CursorLine cterm=NONE ctermbg=black"
-- vim.cmd "hi NonText cterm=NONE ctermfg=NONE"
vim.opt.fillchars.eob = " " -- show empty lines at the end of a buffer as ` ` {default `~`}
vim.opt.shortmess:append "c" -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"
vim.opt.whichwrap:append "<,>,[,],h,l" -- keys allowed to move to the previous/next line when the beginning/end of line is reached
vim.opt.iskeyword:append "-" -- treats words with `-` as single words
vim.opt.formatoptions:remove { "c", "r", "o" } -- This is a sequence of letters which describes how automatic formatting is to be done
vim.opt.linebreak = true
-- show window title
vim.opt.title = true

-- DIRs

-- backups / undo history
-- vim.opt.undodir = HOME .. "/.local/share/nvim/undo//"
-- vim.opt.directory = HOME .. "/.local/share/nvim/swap//"
-- vim.opt.undofile = true
-- vim.opt.backup = true
-- do not use swap file (backup + undofile is enough)
-- vim.opt.swapfile = false

-- files to ignore
vim.opt.wildmode = "list:longest,list:full"
vim.opt.wildignore:append "*.o,*.obj,*.rbc,*.class,vendor/gems/*,*.pb.go"
vim.opt.wildignore:append ",*.jpg,*.jpeg,*.gif,*.png,*.xpm,*.webp"
vim.opt.wildignore:append ",*.zip,*.apk,*.gz,.DS_Store"
vim.opt.wildignore:append ",.svn,CVS,.git,.hg"
vim.opt.wildignore:append ",node_modules,deps,build,bin,tmp"
vim.opt.wildignore:append ",.cache,.pnpm,.idea,.vscode,.terraform,__pycache__"
vim.opt.wildignore:append "deps,.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc"
-- on TAB, complete options for system command
vim.opt.wildmenu = true

-------------- EDITING --------------
-- set backspace behavior
vim.opt.backspace = "start,eol,indent"
-- show matching brackets.
vim.opt.showmatch = true
-- go one char past end of line
-- vim.opt.virtualedit = "onemore"
vim.opt.virtualedit = "onemore"
vim.opt.startofline = false
-- mark end column
vim.opt.colorcolumn = "80"
-- reload files automatically
vim.opt.autoread = true
-- show cursor column
vim.opt.ruler = true
-- wrap lines by default (<leader>w to toggle)
vim.opt.wrap = true
-- whitespace
vim.opt.autoindent = true
-- characters used to display various whitespace
vim.opt.list = true
vim.opt.listchars = "tab:▸\\ ,trail:·,extends:»,precedes:«,nbsp:␣"
-- distinct wrapping indicator
vim.opt.showbreak = " ↳ "
-- formatting preferences for all text, regardless of language/LSP
-- q: comment formatting
-- n: use numbered lists
-- j: remove comments when joining lines
-- 1: don't break after one-letter word
-- vim.opt.formatoptions = "qnj1"

-------------- SEARCH --------------

-- incremental search (searches as you type)
vim.opt.incsearch = true
vim.opt.dictionary = "/usr/share/dict/words"
-- ag
vim.g.ag_working_path_mode = "r"

vim.opt.guifont = "RobotoMono Nerd Font Mono:h14" -- the font used in graphical neovim applications
vim.opt.guicursor:append "a:blinkon0"
vim.opt.linespace = 0
vim.g.neovide_scroll_animation_length = 0.04
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_refresh_rate = 120
vim.g.neovide_cursor_trail_size = 0.1
vim.g.neovide_cursor_vfx_mode = ""
vim.g.neovide_input_use_logo = 1
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_scale_factor = 1.2
