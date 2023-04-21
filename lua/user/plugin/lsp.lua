-- some pieces of this need to be called in a specific order (e.g. null-ls and mason stuff), so one mega setup fn is the simplest solution
local function setup_lsp()
  local lsp = require("lsp-zero").preset { "recommended" }
  local null_ls = require "null-ls"
  local lspconfig = require "lspconfig"
  lsp.on_attach(function(client, bufnr)
    local opts = { buffer = true, silent = true, noremap = true }
    vim.keymap.set("n", "gD", "<cmd>Telescope lsp_type_definitions<CR>", opts)
    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
    vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
    vim.keymap.set("n", "gr", "<cmd>Telescope lsp_referencess<CR>", opts)
    vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
    vim.keymap.set("n", "<leader>lI", "<cmd>Mason<cr>", opts)
    vim.keymap.set("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    vim.keymap.set("n", "ge", "<cmd>lua vim.diagnostic.goto_next({buffer=" .. bufnr .. "})<cr>", opts)
    vim.keymap.set("n", "gp", "<cmd>lua vim.diagnostic.goto_prev({buffer=" .. bufnr .. "})<cr>", opts)
    vim.keymap.set("n", ";", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    vim.keymap.set("n", "rn", "<cmd>lua require('cosmic-ui').rename()<CR>", opts)
    vim.keymap.set("n", "ga", '<cmd>lua require("cosmic-ui").code_actions()<cr>')
    vim.keymap.set("v", "ga", '<cmd>lua require("cosmic-ui").range_code_actions()<cr>', opts)
    vim.keymap.set("n", "gf", "<cmd>LspZeroFormat! null-ls<cr>", opts) -- ! = async formatting

    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
      return
    end
    illuminate.on_attach(client)
  end)

  lsp.set_server_config {
    single_file_support = false,
  }

  lsp.skip_server_setup { "denols" }

  lsp.set_sign_icons {
    error = "",
    warn = "",
    hint = "",
    info = "◌",
  }

  lsp.format_on_save {
    servers = {
      ["null-ls"] = { "typescript", "typescriptreact", "javascript", "javascriptreact", "lua" },
      ["tsserver"] = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
      ["gopls"] = { "go" },
      ["lua_ls"] = { "lua" },
    },
  }

  lsp.ensure_installed {
    -- Replace these with whatever servers you want to install
    "tsserver",
    "gopls",
    "lua_ls",
  }
  lspconfig.tsserver.setup {
    root_dir = function()
      return lsp.dir.find_first { "pnpm-workspace.yaml" }
    end,
  }
  lspconfig.lua_ls.setup {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  }

  lsp.setup()

  -- null-ls
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  local code_actions = null_ls.builtins.code_actions
  local hover = null_ls.builtins.hover
  null_ls.setup {
    debug = false,
    sources = {
      formatting.stylua,
      formatting.gofmt,
      formatting.htmlbeautifier,
      formatting.jq,

      -- formatting.prettier,
      formatting.prettierd,

      formatting.eslint_d,
      diagnostics.eslint_d,
      code_actions.eslint_d,

      hover.printenv,
    },
  }

  require("mason-null-ls").setup {
    ensure_installed = {
      "eslint_d",
      "prettierd",
      "stylua",
      "shellcheck",
      "goimports",
    },
    automatic_installation = true,
    handlers = {}, -- nil handler will use default handler for all sources
  }
end

return {
  -- completion / lsp icons based on item type
  -- { "onsails/lspkind.nvim" },
  -- lsp progress inidicator
  { "j-hui/fidget.nvim" },
  -- lsp boilerplate abstraction
  {
    "VonHeikemen/lsp-zero.nvim",
    event = "BufRead",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      {
        -- Optional
        "williamboman/mason.nvim",
        build = function()
          pcall(vim.cmd, "MasonUpdate")
        end,
      },
      { "williamboman/mason-lspconfig.nvim" }, -- Optional
      { "jose-elias-alvarez/null-ls.nvim" },
      { "jay-babu/mason-null-ls.nvim" },
      -- Autocompletion
      { "hrsh7th/nvim-cmp" },     -- Required
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "L3MON4D3/LuaSnip" },     -- Required
    },
    config = setup_lsp,
  },
  -- floating previews for LSP definitions, references etc
  {
    "rmagatti/goto-preview",
    event = "LspAttach",
    dependencies = {
      {
        "folke/trouble.nvim",
        "nvim-telescope/telescope.nvim",
      },
      {
        "CosmicNvim/cosmic-ui",
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        config = function()
          require("cosmic-ui").setup()
        end,
      },
    },
    config = function()
      return {
        width = 80,                                          -- Width of the floating window
        height = 15,                                         -- Height of the floating window
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- Border characters of the floating window
        default_mappings = false,                            -- Bind default mappings
        debug = false,                                       -- Print debug information
        opacity = nil,                                       -- 0-100 opacity level of the floating window where 100 is fully transparent.
        resizing_mappings = false,                           -- Binds arrow keys to resizing the floating window.
        post_open_hook = nil,                                -- A
        references = {                                       -- Configure the telescope UI for slowing the references cycling window.
          telescope = require("telescope.themes").get_dropdown { hide_preview = false },
        },
        -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
        focus_on_open = false,                     -- Focus the floating window when opening it.
        dismiss_on_move = true,                    -- Dismiss the floating window when moving the cursor.
        force_close = true,                        -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
        bufhidden = "wipe",                        -- the bufhidden option to set on the floating window. See :h bufhidden
        stack_floating_preview_windows = false,    -- Whether to nest floating windows
        preview_window_title = { enable = false }, -- Whether to set
      }
    end,
  },
  -- DAP,
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui" },
  { "ravenxrz/DAPInstall.nvim" },
}
