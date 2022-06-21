vim.cmd([[
  Plug 'norcalli/nvim-colorizer.lua'
]])

require("au")["User LoadPluginConfig"] = function()
	require("colorizer").setup({ "json", "xml", "html", "css", "ps1", "lua", "vim", "yaml" })
end
