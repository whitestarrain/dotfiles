local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "mfussenegger/nvim-lint"
plugin.loadEvent = "VeryLazy"

-- support toggle. l
vim.g.enable_linter = false
local augroup_name = "nvim_lint_augroup"
local lint_toggle = function()
  local linter = require("lint")
  -- enable lint
  if not vim.g.enable_linter then
    local avaliable_linters = linter._resolve_linter_by_ft(vim.bo.filetype)
    if next(avaliable_linters) == nil then
      vim.notify("nvim-lint: no avaliable linter for current file")
      return
    end

    local augroup = vim.api.nvim_create_augroup(augroup_name, { clear = true })
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
      group = augroup,
      callback = function()
        linter.try_lint()
      end,
    })
    linter.try_lint()
  end
  -- disable lint, and reset lint diagnostict
  if vim.g.enable_linter then
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
  end
  -- set marker value
  vim.g.enable_linter = not vim.g.enable_linter
  -- re-calculate statusline
  vim.cmd([[let &stl=&stl]])
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
