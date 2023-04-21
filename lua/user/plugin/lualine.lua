local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
}

local filetype = {
  "filetype",
  icons_enabled = false,
}

local location = {
  "location",
  padding = 0,
}

return {
  -- status line
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "gruvbox-material",
        icons_enabled = true,
        globalstatus = true,
        component_separators = "",
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha", "dashboard" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { diagnostics },
        lualine_c = {
          diff,
          {
            "filename",
            file_status = true, -- Displays file status (readonly status, modified status)
            newfile_status = false, -- Display new file status (new file means no write after created)
            path = 4, -- 4: Filename and parent dir
            shorting_target = 40, -- Shortens path to leave 40 spaces in the window
            symbols = {
              modified = "  ",
              readonly = "  ",
              unnamed = "  ",
              newfile = "  ",
            },
          },
        },
        lualine_x = { diff, filetype },
        lualine_y = { location },
        lualine_z = { "branch" },
      },
    },
  },
}