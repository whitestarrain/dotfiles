local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "b3nj5m1n/kommentary"
plugin.loadEvent = "VeryLazy"
plugin.config = function()
  vim.g.kommentary_create_default_mappings = false

  require("wsain.plugin.whichkey").register({

    { "gcc", "<Plug>kommentary_line_default" },
    { "gc", "<Plug>kommentary_motion_default" },
    { "gc", "<Plug>kommentary_visual_default<C-c>", mode = "v" },

    -- about <C-/>
    -- For some reason, vim registers <C-/> as <C-_>
    -- {you can see it in insert mode using <C-v><C-/>}. It can be the terminal or a historical design thing that terminal apps have to suffer.
    -- And Gvim doesn't even try to recognize <C-/>. Sees it as single /.
    { "<C-_>", "<Plug>kommentary_line_default" },
    { "<C-_>", "<C-\\><C-O><Plug>kommentary_line_default", mode = "i" },
    { "<C-_>", "<Plug>kommentary_visual_default<C-c>", mode = "v" },

    -- 针对nvim-qt
    { "<C-/>", "<Plug>kommentary_line_default", mode = "n" },
    { "<C-/>", "<C-\\><C-O><Plug>kommentary_line_default", mode = "i" },
    { "<C-/>", "<Plug>kommentary_visual_default<C-c>", mode = "v" },
  })
end
return plugin
