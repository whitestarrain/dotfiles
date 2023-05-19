local plugin = require("wsain.plugin.template"):new()
plugin.shortUrl = "mfussenegger/nvim-dap"
plugin.loadEvent = "VeryLazy"
plugin.dependencies = {
  "rcarriga/nvim-dap-ui",
}
plugin.config = function()
  vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
end
return plugin
