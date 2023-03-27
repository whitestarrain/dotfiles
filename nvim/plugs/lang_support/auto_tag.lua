-- Before        Input         After
-- ------------------------------------
-- <div           >              <div></div>
-- <div></div>    ciwspan<esc>   <span></span>
-- ------------------------------------

vim.cmd([[
  Plug 'windwp/nvim-ts-autotag'
]])

require("au")["User LoadPluginConfig"] = function()
  -- User treesitter setup
  local status, treesitterConfig = pcall(require, "nvim-treesitter.configs")
  treesitterConfig.setup({
    autotag = {
      enable = true,
    },
  })
end
