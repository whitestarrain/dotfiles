vim.cmd([[
  Plug 'neovim/nvim-lspconfig'

  " lsp ui美化
  Plug 'tami5/lspsaga.nvim'
]])

require("au")["User LoadPluginConfig"] = function()
	-- icon config
	local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	-- handler 配置，添加参数
	-- help vim.lsp.util.open_floating_preview() -- 读读源码，这部份实现不算难
	local lsp = vim.lsp
	-- Global handlers.
	lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, {
		border = "single",
		offset_x = 1,
		max_width = 100,
		max_height = 20,
	})

	lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, {
		border = "single",
		max_width = 100,
		max_height = 20,
	})
end
