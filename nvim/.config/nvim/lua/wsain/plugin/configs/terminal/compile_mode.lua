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
    baleia_setup = true,
  }
  local function stay_on_compilation_win()
    vim.schedule(function()
      local compilation_win = vim.fn.win_findbuf(vim.g.compilation_buffer)[1]
      if compilation_win ~= nil then
        vim.api.nvim_set_current_win(compilation_win)
      end
    end)
  end

  require("wsain.plugin.whichkey").register({
    { "<leader>c", group = "code" },
    {
      "<leader>cc",
      function()
        vim.cmd("Compile")
        stay_on_compilation_win()
      end,
      desc = "compile",
    },
    { "<leader>cC", ":Recompile<cr>", desc = "recompile" },
  })
end

return plugin
