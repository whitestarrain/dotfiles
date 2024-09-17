local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "windwp/nvim-autopairs"
plugin.loadEvent = "VeryLazy"
plugin.config = function()
  require("nvim-autopairs").setup({
    enable_check_bracket_line = false
  })

  require("nvim-autopairs").get_rule("'")[1].not_filetypes = { "scheme", "lisp" }

  local status, cmp = pcall(require, "cmp")
  if status then
    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end
end

return plugin
