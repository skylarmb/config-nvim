-- some pieces of this need to be called in a specific order (e.g. null-ls and mason stuff), so one mega setup fn is the simplest solution

local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
  Copilot = "",
}

local severity = vim.diagnostic.severity
local severity_icons = {
  [severity.ERROR] = "",
  [severity.WARN] = "",
  [severity.INFO] = "",
  [severity.HINT] = "",
  -- eslint_d = "",
  -- eslint = "",
  -- tsserver = "",
  -- typescript = "",
  -- lua_syntax_check = "󰢱",
  -- lua_diagnostics = "󰢱",
}

local function setup_lsp()
  local illuminate = require("illuminate")
  local colorizer = require("colorizer")
  local null_ls = require("null-ls")
  local lspconfig = require("lspconfig")

  ---- LSP ----
  local lsp = require("lsp-zero").preset({
    name = "recommended",
    float_border = "shadow",
    set_lsp_keymaps = {
      preserve_mappings = true,
      omit = { "[d", "]d", "gs", "K" },
    },
  })

  local on_attach = function(client, bufnr)
    local opts = { buffer = true, silent = true, noremap = true }
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

    illuminate.on_attach(client)
    colorizer.attach_to_buffer(bufnr)
    local function debug_handler(name, handler)
      return function(...)
        local args = { ... }
        print("---DEBUG: " .. name .. " ---")
        print(vim.inspect(args[2]))

        -- handler(...)
        vim.lsp.util.open_floating_preview(
          {
            "hello",
            "world",
          },
          "",
          {
            height = 10,
            width = 60,
            focus = false,
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          }
        )
      end
    end
    local open_float = vim.lsp.util.open_floating_preview
    local box = {
      topleft = "┏",
      topright = "┓",
      bottomleft = "┗",
      bottomright = "┛",
      bottom = "▁",
      top = "▔",
      vertical = "┃",
      horizontal = "━",
      left = "▏",
      right = "▕",
    }

    vim.lsp.util.open_floating_preview = function(contents, syntax, o)
      local function border(side)
        local b = string.rep(box.horizontal, (o.width or 80) - 2)
        if side == "top" then
          return box.topleft .. b .. box.topright
        end
        return box.bottomleft .. b .. box.bottomright
      end
      local function is_box_char(char)
        local res = char:match("^[" .. table.concat(vim.tbl_values(box), "|") .. "]")
        return res
      end
      contents = vim.tbl_filter(function(v)
        return v ~= "" and v ~= nil
      end, contents)
      local first = contents[1]
      local last = contents[#contents]
      if not is_box_char(first) then
        table.insert(contents, 1, border("top"))
      end
      if not is_box_char(last) then
        table.insert(contents, border("bottom"))
      end
      contents = vim.tbl_map(function(v)
        if not is_box_char(v) then
          return string.format("%s %-78s %s", box.vertical, v, box.vertical)
        end
        return v
      end, contents)
      print(vim.inspect(contents))
      local res = open_float(contents, "Pmenu", o)
      return res
    end
    vim.diagnostic.config({
      virtual_text = false,
      float = {
        scope = "line",
        border = "shadow",
        severity_sort = true,
        source = false,
        header = "",
        prefix = "",
        format = function(diagnostic)
          print(vim.inspect(diagnostic))
          local source = string.lower(diagnostic.source):gsub("[^%w]", "_"):gsub("_$", "")
          local prefix = (severity_icons[diagnostic.severity] or "") .. " "
          local message = " " .. diagnostic.message .. " "
          return prefix .. source .. " \n" .. message
        end,
      },
    })
  end

  lsp.on_attach(on_attach)

  lsp.set_server_config({
    single_file_support = false,
  })

  lsp.set_sign_icons({
    error = "",
    warn = "",
    hint = "",
    info = "◌",
  })

  lsp.format_on_save({
    servers = {
      ["null-ls"] = { "typescript", "typescriptreact", "javascript", "javascriptreact", "lua" },
      ["tsserver"] = {},
      -- ["denols"] = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
      ["gopls"] = { "go" },
      ["lua_ls"] = {},
      ["dockerls"] = { "dockerfile" },
    },
    format_opts = {
      async = false,
      timeout_ms = 2000,
    },
  })

  lsp.ensure_installed({
    -- Replace these with whatever servers you want to install
    "tsserver",
    "gopls",
    "lua_ls",
    "dockerls",
  })
  -- local denols_cmd = { "deno", "lsp" }
  -- local tsproject = lsp.dir.find_first({ "tsconfig.json" })
  -- if tsproject ~= nil then
  --   denols_cmd = { "deno", "lsp", "--config", tsproject .. "/tsconfig.json" }
  -- end
  -- lspconfig.denols.setup({
  --   root_dir = function()
  --     return lsp.dir.find_first({ "tsconfig.json" })
  --   end,
  --   cmd = denols_cmd
  -- })
  -- lspconfig.tsserver.setup()
  require("typescript").setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    go_to_source_definition = {
      fallback = true, -- fall back to standard LSP definition on failure
    },
    server = { -- pass options to lspconfig's setup method
      on_attach = on_attach,
      root_dir = function()
        return lsp.dir.find_first({
          "package.json",
          "tsconfig.json",
          "pnpm-workspace.yaml",
          ".luarc.json",
          ".stylua.toml",
          ".git",
        })
      end,
    },
  })

  lsp.skip_server_setup({ "denols" })

  lspconfig.lua_ls.setup({
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
          checkThirdParty = false,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  })

  lsp.setup()

  ---- NULL-LS ----
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  local code_actions = null_ls.builtins.code_actions
  local hover = null_ls.builtins.hover
  null_ls.setup({
    debug = false,
    sources = {
      formatting.stylua,
      -- formatting.luaformatter,
      formatting.gofmt,
      formatting.htmlbeautifier,
      formatting.jq,

      formatting.prettierd,
      formatting.prettierd,

      formatting.eslint_d,
      diagnostics.eslint_d,
      code_actions.eslint_d,

      hover.printenv,
    },
  })

  require("mason-null-ls").setup({
    ensure_installed = {
      "eslint_d",
      "prettierd",
      "stylua",
      "shellcheck",
      "goimports",
    },
    automatic_installation = false,
    handlers = {}, -- nil handler will use default handler for all sources
  })
  -- vim.diagnostic.config({
  --   virtual_text = false,
  --   float = {
  --     scope = "line",
  --     pad_top = 0,
  --     pad_bottom = 1,
  --     width = 80,
  --     -- border = "shadow",
  --     -- border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
  --     border = {
  --       { " ", "FloatShadowThrough" },
  --       { " ", "FloatShadowThrough" },
  --       { " ", "FloatShadowThrough" },
  --       { "▏", "FloatShadow" },
  --       { " ", "FloatShadow" },
  --       { "▔", "FloatShadow" },
  --       { " ", "FloatShadowThrough" },
  --       { "▕", "FloatShadowThrough" },
  --     },
  --
  --     severity_sort = true,
  --     -- border = {
  --     --   { "╭", "FloatBorder" },
  --     --   { "─", "FloatBorder" },
  --     --   { "╮", "FloatBorder" },
  --     --   { "│", "FloatBorder" },
  --     --   { "╯", "FloatBorder" },
  --     --   { "─", "FloatBorder" },
  --     --   { "╰", "FloatBorder" },
  --     --   { "│", "FloatBorder" },
  --     -- },
  --     source = false,
  --     header = " ",
  --     -- {
  --     --   " " .. string.rep("─", 78) .. " ",
  --     --   "Pmenu",
  --     -- },
  --     prefix = " ",
  --     suffix = " ",
  --     -- float_border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- Border characters of the floating window
  --     -- float_border = {
  --     --   { "╭", "FloatBorder" },
  --     --   { "▔", "FloatBorder" },
  --     --   { "╲", "FloatBorder" },
  --     --   { "▕", "FloatBorder" },
  --     --   { "╯", "FloatBorder" },
  --     --   { "▁", "FloatBorder" },
  --     --   { "╲", "FloatBorder" },
  --     --   { "▏", "FloatBorder" },
  --     -- float_border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
  --     -- },
  --
  --     -- todo:
  --     -- icon per source
  --     -- typescript source name?
  --     format = function(diagnostic)
  --       print(vim.inspect(diagnostic))
  --       local source = string.lower(diagnostic.source):gsub("[^%w]", "_"):gsub("_$", "")
  --       local prefix = (severity_icons[diagnostic.severity] or "") .. " "
  --       local message = " " .. diagnostic.message .. " "
  --       return prefix .. source .. " \n" .. message .. "\n"
  --     end,
  --   },
  -- })

  ---- CMP ----
  require("copilot").setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
  })
  require("copilot_cmp").setup()
  local cmp = require("cmp")

  local popup_style = {
    border = "shadow",
    col_offset = -2,
    scrollbar = false,
    scrolloff = 0,
    -- side_padding = 4,
    zindex = 1001,
  }
  cmp.setup({
    sources = {
      { name = "copilot" },
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "buffer" },
      { name = "luasnip" },
    },
    experimental = {
      ghost_text = true,
    },
    window = {
      completion = popup_style,
      documentation = popup_style,
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        vim_item.kind = kind_icons[vim_item.kind]
        vim_item.menu = ({
          nvim_lsp = "",
          nvim_lua = "",
          luasnip = "",
          buffer = "",
          path = "",
          emoji = "",
        })[entry.source.name]
        return vim_item
      end,
    },
    mapping = {
      ["<C-y>"] = cmp.mapping.confirm({
        -- documentation says this is important.
        -- I don't know why.
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }),
    },
  })
end

return {
  {
    "VonHeikemen/lsp-zero.nvim",
    lazy = false,
    event = { "BufRead" },
    branch = "v2.x",
    dependencies = {
      { "j-hui/fidget.nvim" },
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      {
        -- Optional
        "williamboman/mason.nvim",
        build = function()
          vim.cmd("MasonUpdate")
        end,
      },
      { "williamboman/mason-lspconfig.nvim" }, -- Optional
      { "jose-elias-alvarez/null-ls.nvim" },
      { "jay-babu/mason-null-ls.nvim" },
      -- Shims / API for tsserver functionality
      { "jose-elias-alvarez/typescript.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" }, -- Required, managed in cmp.lua
      { "hrsh7th/cmp-nvim-lsp" }, -- Required, managed in cmp.lua
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
      { "L3MON4D3/LuaSnip" }, -- Required, managed in cmp.lua
      { "zbirenbaum/copilot.lua" },
      { "zbirenbaum/copilot-cmp" },

      -- debug,
      { "vim-scripts/Decho" },
    },
    config = setup_lsp,
  },
  -- floating previews for LSP definitions, references etc
  {
    "rmagatti/goto-preview",
    event = { "LspAttach" },
    dependencies = {
      {
        "folke/trouble.nvim",
        opts = {
          severity = vim.diagnostic.severity.ERROR,
        },
      },
      { "nvim-telescope/telescope.nvim" },
      { "nvim-colorizer.lua" },
      {
        "CosmicNvim/cosmic-ui",
        dependencies = { "nui.nvim", "plenary.nvim" },
        config = function()
          require("cosmic-ui").setup()
        end,
      },
    },
    config = function()
      return {
        width = 80, -- Width of the floating window
        height = 15, -- Height of the floating window
        border = "shadow",
        -- border = "shadow",
        default_mappings = false, -- Bind default mappings
        debug = false, -- Print debug information
        opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
        resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
        post_open_hook = nil, -- A
        references = { -- Configure the telescope UI for slowing the references cycling window.
          telescope = require("telescope.themes").get_dropdown({ hide_preview = false }),
        },
        -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
        focus_on_open = false, -- Focus the floating window when opening it.
        dismiss_on_move = true, -- Dismiss the floating window when moving the cursor.
        force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
        bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
        stack_floating_preview_windows = false, -- Whether to nest floating windows
        preview_window_title = { enable = false }, -- Whether to set
      }
    end,
  },
}
