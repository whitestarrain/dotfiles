local plugin = require("wsain.plugin.template"):new()
local utils = require("wsain.utils")

plugin.shortUrl = "nvim-lualine/lualine.nvim"
plugin.dependencies = { "nvim-tree/nvim-web-devicons" }
plugin.config = function()
  -- Get diff data
  -- support plugins: vim-gitgutter vim-signify coc-git
  local function get_hunks_data()
    -- { added = add_count, modified = modified_count, removed = removed_count }
    local diff_data = { 0, 0, 0 }
    if vim.fn.exists("b:gitsigns_status") == 1 then
      local gitsigns_dict = vim.b.gitsigns_status_dict
      diff_data[1] = gitsigns_dict.added or 0
      diff_data[2] = gitsigns_dict.changed or 0
      diff_data[3] = gitsigns_dict.removed or 0
    elseif vim.fn.exists("*GitGutterGetHunkSummary") == 1 then
      for idx, v in pairs(vim.fn.GitGutterGetHunkSummary()) do
        diff_data[idx] = v
      end
    elseif vim.fn.exists("*sy#repo#get_stats") == 1 then
      diff_data[1] = vim.fn["sy#repo#get_stats"]()[1]
      diff_data[2] = vim.fn["sy#repo#get_stats"]()[2]
      diff_data[3] = vim.fn["sy#repo#get_stats"]()[3]
    end
    return {
      added = diff_data[1],
      modified = diff_data[2],
      removed = diff_data[3],
    }
  end

  local function get_lsp_client()
    local msg = ""
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end

  local conditions = {
    buffer_not_empty = function()
      return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_by_columns_100 = function()
      return vim.o.columns > 100
    end,
    hide_by_columns_80 = function()
      return vim.o.columns > 80
    end,
    check_git_workspace = function()
      local filepath = vim.fn.expand("%:p:h")
      local gitdir = vim.fn.finddir(".git", filepath .. ";")
      return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
  }

  local function get_lualine_theme()
    if vim.g.colors_name == "neosolarized" then
      return "solarized_dark"
    end
    return "auto"
  end

  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = get_lualine_theme(),
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
      disabled_filetypes = { "Outline", "undotree", "diff", "startify" },
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = {
        {
          "filename",
          file_status = true, -- displays file status (readonly status, modified status)
          path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
          separator = { right = nil },
        },
        {
          "diff",
          colored = true, -- Displays a colored diff status if set to true
          symbols = { added = "  ", modified = " ", removed = " " }, -- Changes the symbols used by the diff.
          source = get_hunks_data,
          separator = { left = nil, right = nil },
          cond = conditions.hide_by_columns_80,
        },
        {
          -- Insert mid section. You can make any number of sections in neovim :)
          -- for lualine it's any number greater then 2
          function()
            return "%="
          end,
          separator = { left = nil, right = nil },
          cond = conditions.hide_by_columns_100,
        },
        {
          get_lsp_client,
          icon = " LSP:",
          cond = function()
            local tbl = { ["dashboard"] = true, [""] = true }
            if tbl[vim.bo.filetype] then
              return false
            end
            return conditions.buffer_not_empty() and conditions.hide_by_columns_100()
          end,
          color = { fg = utils.colors.cyan, gui = "bold" },
        },
      },
      lualine_x = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = { error = " ", warn = " ", info = " ", hint = " " },
          cond = conditions.hide_by_columns_100,
        },
        {
          "fileformat",
          symbols = {
            unix = "unix",
            dos = "dos",
            mac = "mac",
          },
          cond = conditions.hide_by_columns_100,
        },
        "encoding",
        {
          "filetype",
          cond = conditions.hide_by_columns_100,
        },
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          "filename",
          file_status = true, -- displays file status (readonly status, modified status)
          path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
        },
      },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = { "fugitive", "nvim-tree" },
  })
end

return plugin
