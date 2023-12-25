local plugin = require("wsain.plugin.template"):new()
local utils = require("wsain.utils")

plugin.shortUrl = "stevearc/conform.nvim"
plugin.loadEvent = "VeryLazy"
plugin.config = function()
  -- formatter config
  local python_formater = utils.getOs() == "win" and "black" or "darker"
  require("conform").setup({
    formatters = {
      sqlfmt = {
        command = "sqlfmt",
        args = "-", -- stdin
        stdin = true,
        require_cwd = false,
        inherit = false,
      },
    },
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { { "prettierd", "prettier" } },
      html = { { "prettierd", "prettier" } },
      typescript = { { "prettierd", "prettier" } },
      jsx = { { "prettierd", "prettier" } },
      tsx = { { "prettierd", "prettier" } },
      css = { { "prettierd", "prettier" } },
      json = { { "prettierd", "prettier" } },
      markdown = { { "prettierd", "prettier" } },
      bash = { "shfmt" },
      sh = { "shfmt" },
      python = { python_formater, "isort" },
      sql = { "sqlfmt" },
    },
  })
end

-- custom format function
local function complex_format(opts)
  local status, conform = pcall(require, "conform")
  local bufnr = vim.api.nvim_get_current_buf()
  opts = opts or {}

  -- get available formatters
  local formatters = conform.list_formatters(bufnr)
  local prettier_format_available = false
  local prettier_executable = false
  for index, formatter in ipairs(formatters) do
    if formatter["available"] ~= true then
      table.remove(formatters, index)
      goto continue
    end
    if formatter["name"] == "prettier" or formatter["name"] == "prettierd" then
      prettier_format_available = true
    end
    ::continue::
  end
  local all_formatters = conform.list_all_formatters()
  for _, formatter in ipairs(all_formatters) do
    if formatter["available"] == true and formatter["name"] == "prettier" then
      prettier_executable = true
      break
    end
  end

  -- get format opts
  local format_opts = {
    timeout_ms = 10000,
    bufnr = bufnr,
  }
  if opts["range"] ~= nil and opts["range"] ~= 0 then
    local start_line = opts["line1"]
    local end_line = opts["line2"]
    local end_line_length = string.len(vim.api.nvim_buf_get_lines(0, end_line - 1, end_line, false)[1] or "")
    format_opts["range"] = {
      ["start"] = { start_line, 1 },
      ["end"] = { end_line, end_line_length + 1 },
    }
  end

  -- prettier range format
  if opts["range"] ~= nil and opts["range"] ~= 0 and prettier_executable and prettier_format_available then
    utils.prettier_range_format(bufnr, format_opts["range"]["start"][1], format_opts["range"]["end"][1])
    return
  end

  -- conform format
  if status and #formatters > 0 then
    conform.format(format_opts)
    return
  end

  -- lsp format
  vim.lsp.buf.format(format_opts)
end

-- define command
vim.api.nvim_create_user_command("Format", complex_format, { desc = "format", range = 2 })

return plugin
