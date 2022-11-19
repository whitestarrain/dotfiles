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
  require("nvim-treesitter.configs").setup({
    autotag = {
      enable = true,
    },
  })
end
