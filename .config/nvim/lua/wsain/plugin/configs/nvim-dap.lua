local plugin = require("wsain.plugin.template"):new()
plugin.shortUrl = "mfussenegger/nvim-dap"
plugin.loadEvent = "VeryLazy"
plugin.dependencies = {
  "rcarriga/nvim-dap-ui",
}
plugin.config = function()
  vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
  vim.fn.sign_define("DapLogPoint", { text = "󰌑", texthl = "DiagnosticHint", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
end
return plugin
