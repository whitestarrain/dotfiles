vim.cmd("Plug 'mhartington/formatter.nvim'")

local au = require("au")

au["User LoadPluginConfig"] = function() -- autocmd调用函数
	require("formatter").setup({
		filetype = {
			-- DEPN: scoop install stylua
			lua = {
				require("formatter.filetypes.lua").stylua,
			},
		},
	})
end

au.group('FormatGroup', {
    { 'BufWritePost', '*.lua', 'FormatWrite' },
})

