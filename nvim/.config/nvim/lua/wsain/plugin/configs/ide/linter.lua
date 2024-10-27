local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "mfussenegger/nvim-lint"
plugin.loadEvent = "VeryLazy"

-- support toggle. l
local linter_marker = false
local augroup_name = "nvim_lint_augroup"
local lint_toggle = function()
  local linter = require("lint")
  -- enable lint
  if not linter_marker then
    local avaliable_linters = linter._resolve_linter_by_ft(vim.bo.filetype)
    if next(avaliable_linters) == nil then
      vim.notify("nvim-lint: no avaliable linter for current file")
      return
    end

    local augroup = vim.api.nvim_create_augroup(augroup_name, { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      group = augroup,
      callback = function()
        linter.try_lint()
      end,
    })
    linter.try_lint()
    vim.notify("nvim-lint: lint code")
  end
  -- disable lint, and reset lint diagnostict
  if linter_marker then
    vim.api.nvim_clear_autocmds({ group = augroup_name })
    local diagnostic_namespaces = vim.diagnostic.get_namespaces()
    if diagnostic_namespaces ~= nil and next(diagnostic_namespaces) ~= nil then
      for namespace_id, namespace_conf in pairs(diagnostic_namespaces) do
        if namespace_conf == nil or namespace_conf["name"] == nil then
          goto continue
        end
        local start_index, end_index = string.find(namespace_conf["name"], "vim.lsp")
        if start_index == nil and end_index == nil then
          vim.diagnostic.reset(namespace_id)
        end
        ::continue::
      end
    end
    vim.notify("nvim-lint: disable lint")
  end
  -- set marker value
  linter_marker = not linter_marker
end

plugin.config = function()
  local lint = require("lint")
  lint.linters_by_ft = {
    json = { "jsonlint" },
    python = { "ruff" },
    bash = { "shellcheck" },
    sh = { "shellcheck" },
    sql = { "sqlfluff" },
    lua = { "luacheck" },
    make = { "checkmake" },
    cpp = { "cpplint" },
    c = { "cpplint" },
  }
  require("wsain.plugin.whichkey").register({
    { "<leader>l", lint_toggle, desc = "toggle lint" },
  })
end

return plugin
