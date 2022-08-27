vim.cmd([[
  Plug 'mfussenegger/nvim-lint'
]])

local au = require("au")

au["User LoadPluginConfig"] = function()
	-- DEPN: scoop install shellcheck
	require("lint").linters_by_ft = {
		sh = { "shellcheck" },
	}
end

au.group("LintGroup", {
	{
		{
			"BufWritePost",
			"BufEnter",
		},
		"*.sh",
		function()
			require("lint").try_lint()
		end,
	},
})

-- Some linters require a file to be saved to disk, others support linting stdin input.
-- For such linters you could also define a more aggressive autocmd, for example on the InsertLeave or TextChanged events.
