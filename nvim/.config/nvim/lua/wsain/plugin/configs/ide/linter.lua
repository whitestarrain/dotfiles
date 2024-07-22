local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "mfussenegger/nvim-lint"
plugin.loadEvent = "VeryLazy"

-- support toggle. l
local linter_marker = false
local augroup_name = "nvim_lint_augroup"
local lint_toggle = function()
  -- enable lint
  if not linter_marker then
    local augroup = vim.api.nvim_create_augroup(augroup_name, { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      group = augroup,
      callback = function()
        require("lint").try_lint()
      end,
    })
    require("lint").try_lint()
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
  }
  require("wsain.plugin.whichkey").register({
    { "<leader>l", lint_toggle, desc = "toggle lint" },
  })
end

return plugin
