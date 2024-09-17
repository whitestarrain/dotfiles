local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "whitestarrain/compile-mode.nvim"
plugin.loadEvent = "VeryLazy"
plugin.dependencies = {
  "nvim-lua/plenary.nvim",
  { "m00qek/baleia.nvim", tag = "v1.3.0" },
}
plugin.config = function()
  vim.g.compile_mode = {
    default_command = "make -k",
  }

  require("wsain.plugin.whichkey").register({
    { "<leader>c", group = "code" },
    { "<leader>cc", ":Compile<cr>", desc = "compile" },
    { "<leader>cC", ":Recompile<cr>", desc = "recompile" },
  })
end

return plugin
