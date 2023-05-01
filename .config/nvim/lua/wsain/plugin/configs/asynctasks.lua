local Template = require("wsain.plugin.template")
local plugin = Template:new()
plugin.dependencies = {
  "skywind3000/asyncrun.vim",
}
plugin.init = function()
  vim.g.asyncrun_open = 6
  vim.g.asynctasks_term_pos = "bottom"
  vim.g.asynctasks_extra_config = {
    vim.g.absolute_config_path .. "./others/tasks.ini",
  }
end

return plugin
