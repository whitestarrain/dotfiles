local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "windwp/nvim-autopairs"
plugin.config = function()
  require("nvim-autopairs").setup({})

  local status, cmp = pcall(require, "cmp")
  if status then
    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end
end

return plugin
