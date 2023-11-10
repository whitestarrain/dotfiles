local plugin = require("wsain.plugin.template"):new()
plugin.shortUrl = "christoomey/vim-tmux-navigator"
plugin.init = function()
  vim.g.tmux_navigator_no_mappings = 1
  vim.g.tmux_navigator_save_on_switch = 1
  vim.g.tmux_navigator_disable_when_zoomed = 1
  -- select-pane 's -Z option
  vim.g.tmux_navigator_preserve_zoom = 0
  local opts = { silent = true }
  plugin.globalMappings = {
    { "n", "<C-h>", ":TmuxNavigateLeft<CR>", "h", opts },
    { "n", "<C-j>", ":TmuxNavigateDown<CR>", "j", opts },
    { "n", "<C-k>", ":TmuxNavigateUp<CR>", "k", opts },
    { "n", "<C-l>", ":TmuxNavigateRight<CR>", "l", opts },
  }
end
return plugin
