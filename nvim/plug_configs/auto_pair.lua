vim.cmd("Plug 'windwp/nvim-autopairs'")

require("au")["User LoadPluginConfig"] = function()
	require("nvim-autopairs").setup({})

	local present, _ = pcall(require, "cmp")

	-- 为cmp自动添加括号
	-- If you want insert `(` after select function or method item
	if present then
		-- 为cmp自动添加括号
		-- If you want insert `(` after select function or method item
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

		-- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
		cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = "racket"
	end
end
