local plugin = require("wsain.plugin.template"):new()
local utils = require("wsain.utils")

plugin.shortUrl = "LunarVim/bigfile.nvim"

plugin.config = function()
  local my_vimopts_feature = {
    name = "my_vimopts_feature",
    disable = function()
      vim.opt_local.swapfile = false
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.undolevels = 10
      vim.opt_local.undoreload = 0
      vim.opt_local.list = false
    end,
  }
  local features = {
    "indent_blankline",
    "illuminate",
    "lsp",
    "treesitter",
    -- "syntax",
    -- "filetype",
    my_vimopts_feature,
  }
  -- if disable `matchparen` in win, may not be able to view files
  if require("wsain.utils").getOs() == "linux" then
    table.insert(features, "matchparen")
  end
  require("bigfile").setup({
    -- detect long python files
    filesize = 5, -- size of the file in MiB, the plugin round file sizes to the closest MiB
    pattern = utils.get_check_bigfile_function(10000, 1000, { "markdown", "text", "bash", "sh", "zsh" }),
    features = features,
  })
end

return plugin
