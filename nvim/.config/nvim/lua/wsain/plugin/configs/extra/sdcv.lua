local plugin = require("wsain.plugin.template"):new()
plugin.short_url = "whitestarrain/nvim-sdcv"
plugin.load_event = "VeryLazy"
plugin.config = function()
  require("nvim-sdcv").setup({
    -- optional overrides
    keymap = "<M-s>",
    window = {
      width = 80,
      height = 20,
      border = "rounded",
    },
  })
end
return plugin
