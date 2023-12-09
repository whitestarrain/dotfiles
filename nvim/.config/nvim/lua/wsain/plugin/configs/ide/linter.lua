local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "mfussenegger/nvim-lint"
plugin.loadEvent = "VeryLazy"
plugin.config = function()
  local lint = require("lint")
  lint.linters_by_ft = {
    json = { "jsonlint" },
    python = { "ruff" },
    bash = { "shellcheck" },
    sh = { "shellcheck" },
    sql = { "sqlfluff" },
  }
end

local lint_flag = "custom_lint_flag"

plugin.globalMappings = {
  {
    "n",
    "<leader>l",
    function()
      require("lint").try_lint()
      vim.api.nvim_buf_set_var(0, lint_flag, 1)
    end,
    "lint",
  },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    if vim.b[lint_flag] ~= 1 then
      return
    end
    require("lint").try_lint()
  end,
})

return plugin
