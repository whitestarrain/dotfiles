local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "ej-shafran/compile-mode.nvim"
plugin.loadEvent = "VeryLazy"
plugin.dependencies = {
  "nvim-lua/plenary.nvim",
  { "m00qek/baleia.nvim", tag = "v1.3.0" },
}
plugin.config = function()
  require("compile-mode").setup({
    no_baleia_support = false,
    default_command = "make -k",
    same_window_errors = true,
  })

  local compile_mode_group = vim.api.nvim_create_augroup("compile_mode_group", { clear = true })
  require("wsain.plugin.whichkey").register({
    { "<leader>c", group = "code" },
    { "<leader>cc", ":Compile<cr>", desc = "compile" },
    { "<leader>cC", ":Recompile<cr>", desc = "recompile" },
  })
end

return plugin
