vim.cmd([[
  Plug 'williamboman/mason.nvim'
  Plug 'jay-babu/mason-nvim-dap.nvim'
]])

require("au")["User LoadPluginConfig"] = function()
  local status, mason = pcall(require, "mason")
  if not status then
    return
  end
  mason.setup({
    install_root_dir = vim.g.absolute_config_path .. "mason",
  })
  require("mason-nvim-dap").setup({
      automatic_setup = true,
  })
end
