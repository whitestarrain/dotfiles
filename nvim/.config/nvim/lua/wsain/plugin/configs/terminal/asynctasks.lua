local plugin = require("wsain.plugin.template"):new()
plugin.short_url = "skywind3000/asynctasks.vim"
plugin.load_event = "VeryLazy"
plugin.dependencies = {
  "skywind3000/asyncrun.vim",
}
plugin.init = function()
  vim.g.asyncrun_open = 8
  vim.g.asynctasks_term_pos = "bottom"
  vim.g.asynctasks_extra_config = {
    vim.g.absolute_config_path .. "others/asynctasks.ini",
  }
  vim.g.asynctasks_config_name = '.asynctasks.ini'
end

return plugin
