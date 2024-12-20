local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "tpope/vim-surround"
plugin.loadEvent = "VeryLazy"
plugin.dependencies = {
  "tpope/vim-repeat",
}
plugin.init = function()
  local augroup = vim.api.nvim_create_augroup("PlugNvimSurroundAutoCmd", { clear = true })
  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = augroup,
    pattern = { "md", "markdown" },
    callback = function()
      vim.b["surround_" .. vim.fn.char2nr("c")] = "```\n\r\n```"
      vim.b["surround_" .. vim.fn.char2nr("*")] = " **\r** "
    end,
  })
end

return plugin
