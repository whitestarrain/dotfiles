vim.cmd("Plug 'windwp/nvim-autopairs'")

require("au")["User LoadPluginConfig"] = function()
  require("nvim-autopairs").setup({})

  local status, _ = pcall(require, "cmp")
  if not status then
    return
  end
  -- If you want insert `(` after select function or method item
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local cmp = require("cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end
