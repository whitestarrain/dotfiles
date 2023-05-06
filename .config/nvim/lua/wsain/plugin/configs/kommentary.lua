local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "b3nj5m1n/kommentary"
plugin.config = function()
  vim.g.kommentary_create_default_mappings = false
end
plugin.globalMappings = {
  { "n", "gcc", "<Plug>kommentary_line_default"},
  { "n", "gc", "<Plug>kommentary_motion_default"},
  { "v", "gc", "<Plug>kommentary_visual_default<C-c>"},

  -- about <C-/>
  -- For some reason, vim registers <C-/> as <C-_>
  -- {you can see it in insert mode using <C-v><C-/>}. It can be the terminal or a historical design thing that terminal apps have to suffer.
  -- And Gvim doesn't even try to recognize <C-/>. Sees it as single /.
  { "n", "<C-_>", "<Plug>kommentary_line_default"},
  { "i", "<C-_>", "<C-\\><C-O><Plug>kommentary_line_default"},
  { "v", "<C-_>", "<Plug>kommentary_visual_default<C-c>"},

  -- 针对nvim-qt
  { "n", "<C-/>", "<Plug>kommentary_line_default"},
  { "i", "<C-/>", "<C-\\><C-O><Plug>kommentary_line_default"},
  { "v", "<C-/>", "<Plug>kommentary_visual_default<C-c>"},
}
return plugin
