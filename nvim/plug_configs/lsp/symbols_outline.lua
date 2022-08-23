vim.cmd([[
  Plug 'simrat39/symbols-outline.nvim'
]])

require("au")["User LoadPluginConfig"] = function()
	require("symbols-outline").setup({
		keymaps = { -- These keymaps can be a string or a table for multiple keys
			close = { "<Esc>", "q" },
			goto_location = "<Cr>",
			focus_location = "o",
			hover_symbol = "K",
			toggle_preview = "P",
			rename_symbol = "r",
			-- code_actions = "a",
			fold = "h",
			unfold = "l",
			fold_all = "W",
			unfold_all = "E",
			fold_reset = "R",
		},
		symbols = {
			File = { icon = "", hl = "TSURI" },
			Module = { icon = "", hl = "TSNamespace" },
			Namespace = { icon = "", hl = "TSNamespace" },
			Package = { icon = "", hl = "TSNamespace" },
			Class = { icon = "ﴯ", hl = "TSType" },
			Method = { icon = "ƒ", hl = "TSMethod" },
			Property = { icon = "", hl = "TSMethod" },
			Field = { icon = "ﰠ", hl = "TSField" },
			Constructor = { icon = "", hl = "TSConstructor" },
			Enum = { icon = "ℰ", hl = "TSType" },
			Interface = { icon = "ﰮ", hl = "TSType" },
			Function = { icon = "", hl = "TSFunction" },
			Variable = { icon = "", hl = "TSConstant" },
			Constant = { icon = "", hl = "TSConstant" },
			String = { icon = "", hl = "TSString" },
			Number = { icon = "#", hl = "TSNumber" },
			Boolean = { icon = "⊨", hl = "TSBoolean" },
			Array = { icon = "", hl = "TSConstant" },
			Object = { icon = "⦿", hl = "TSType" },
			Key = { icon = "", hl = "TSType" },
			Null = { icon = "NULL", hl = "TSType" },
			EnumMember = { icon = "", hl = "TSField" },
			Struct = { icon = "פּ", hl = "TSType" },
			Event = { icon = "", hl = "TSType" },
			Operator = { icon = "+", hl = "TSOperator" },
			TypeParameter = { icon = "", hl = "TSParameter" },
		},
	})
end
