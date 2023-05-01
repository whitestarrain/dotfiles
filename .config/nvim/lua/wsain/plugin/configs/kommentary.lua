local Template = require("wsain.plugin.template")
local plugin = Template:new()

plugin.shortUrl = "b3nj5m1n/kommentary"
plugin.config = function()
  vim.g.kommentary_create_default_mappings = false
  vim.api.nvim_set_keymap("n", "gcc", "<Plug>kommentary_line_default", {})
  vim.api.nvim_set_keymap("n", "gc", "<Plug>kommentary_motion_default", {})
  vim.api.nvim_set_keymap("v", "gc", "<Plug>kommentary_visual_default<C-c>", {})

  -- about <C-/>
  -- For some reason, vim registers <C-/> as <C-_>
  -- (you can see it in insert mode using <C-v><C-/>). It can be the terminal or a historical design thing that terminal apps have to suffer.
  -- And Gvim doesn't even try to recognize <C-/>. Sees it as single /.
  vim.api.nvim_set_keymap("n", "<C-_>", "<Plug>kommentary_line_default", {})
  vim.api.nvim_set_keymap("i", "<C-_>", "<C-\\><C-O><Plug>kommentary_line_default", {})
  vim.api.nvim_set_keymap("v", "<C-_>", "<Plug>kommentary_visual_default<C-c>", {})

  -- 针对nvim-qt
  vim.api.nvim_set_keymap("n", "<C-/>", "<Plug>kommentary_line_default", {})
  vim.api.nvim_set_keymap("i", "<C-/>", "<C-\\><C-O><Plug>kommentary_line_default", {})
  vim.api.nvim_set_keymap("v", "<C-/>", "<Plug>kommentary_visual_default<C-c>", {})
end
return plugin
