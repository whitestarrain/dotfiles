vim.cmd([[
  Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
]])

require("au")["User LoadPluginConfig"] = function()
	local gl = require("galaxyline")
	local colors = {
		bg = "NONE",
		fg = "#bbc2cf",
		yellow = "#ECBE7B",
		cyan = "#008080",
		darkblue = "#081633",
		green = "#98be65",
		orange = "#FF8800",
		violet = "#a9a1e1",
		magenta = "#c678dd",
		blue = "#51afef",
		red = "#ec5f67",
	}

	local condition = require("galaxyline.condition")
	local gls = gl.section

	local function short_hide_condition()
		local buf_name = vim.fn.bufname()
		for _, short_line_buf_name in ipairs(gl.short_line_list) do
			local s, e = string.find(string.lower(buf_name), string.lower(short_line_buf_name))
			if s ~= nil then
				return false
			end
		end
		return true
	end

	local get_lsp_client = function(msg)
		msg = msg or ""
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end

		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end

	gl.short_line_list = { "NvimTree", "vista", "dbui", "packer", "TagBar" }

	gls.left[1] = {
		RainbowRed = {
			provider = function()
				return "▊ "
			end,
			condition = short_hide_condition,
			highlight = { colors.blue, colors.bg },
		},
	}
	gls.left[2] = {
		ViMode = {
			provider = function()
				-- auto change color according the vim mode
				local mode_color = {
					n = colors.red,
					i = colors.green,
					v = colors.blue,
					[""] = colors.blue,
					V = colors.blue,
					c = colors.magenta,
					no = colors.red,
					s = colors.orange,
					S = colors.orange,
					[""] = colors.orange,
					ic = colors.yellow,
					R = colors.violet,
					Rv = colors.violet,
					cv = colors.red,
					ce = colors.red,
					r = colors.cyan,
					rm = colors.cyan,
					["r?"] = colors.cyan,
					["!"] = colors.red,
					t = colors.red,
				}
				vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])
				return "  "
			end,
			condition = function()
				return condition.buffer_not_empty() and condition.hide_in_width() and short_hide_condition()
			end,
			highlight = { colors.red, colors.bg, "bold" },
		},
	}
	gls.left[3] = {
		FileSize = {
			provider = "FileSize",
			condition = function()
				return condition.buffer_not_empty() and condition.hide_in_width() and short_hide_condition()
			end,
			highlight = { colors.fg, colors.bg },
		},
	}
	gls.left[4] = {
		FileIcon = {
			provider = "FileIcon",
			condition = function()
				return condition.buffer_not_empty() and short_hide_condition()
			end,
			highlight = { require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg },
		},
	}

	gls.left[5] = {
		FileName = {
			provider = "FileName",
			condition = function()
				return condition.buffer_not_empty() and short_hide_condition()
			end,
			highlight = { colors.magenta, colors.bg, "bold" },
		},
	}

	gls.left[6] = {
		LineInfo = {
			provider = "LineColumn",
			separator = " ",
			separator_highlight = { "NONE", colors.bg },
			highlight = { colors.fg, colors.bg },
		},
	}

	gls.left[7] = {
		PerCent = {
			provider = "LinePercent",
			separator = " ",
			separator_highlight = { "NONE", colors.bg },
			highlight = { colors.fg, colors.bg, "bold" },
		},
	}

	gls.left[8] = {
		ScrollBar = {
			provider = "ScrollBar",
			condition = condition.hide_in_width,
			highlight = { colors.blue, colors.bg },
		},
	}

	gls.left[9] = {
		DiagnosticError = {
			provider = "DiagnosticError",
			icon = "   ",
			highlight = { colors.red, colors.bg },
		},
	}
	gls.left[10] = {
		DiagnosticWarn = {
			provider = "DiagnosticWarn",
			icon = "   ",
			highlight = { colors.yellow, colors.bg },
		},
	}

	gls.left[11] = {
		DiagnosticHint = {
			provider = "DiagnosticHint",
			icon = "   ",
			highlight = { colors.cyan, colors.bg },
		},
	}

	gls.left[12] = {
		DiagnosticInfo = {
			provider = "DiagnosticInfo",
			icon = "   ",
			highlight = { colors.blue, colors.bg },
		},
	}

	gls.mid[1] = {
		ShowLspClient = {
			provider = get_lsp_client,
			condition = function()
				local tbl = { ["dashboard"] = true, [""] = true }
				if tbl[vim.bo.filetype] then
					return false
				end
				return condition.buffer_not_empty() and condition.hide_in_width()
			end,
			icon = " LSP:",
			highlight = { colors.cyan, colors.bg, "bold" },
		},
	}

	gls.right[1] = {
		DiffAdd = {
			provider = "DiffAdd",
			condition = condition.hide_in_width,
			icon = "  ",
			highlight = { colors.green, colors.bg },
		},
	}
	gls.right[2] = {
		DiffModified = {
			provider = "DiffModified",
			condition = condition.hide_in_width,
			icon = " 柳",
			highlight = { colors.orange, colors.bg },
		},
	}
	gls.right[3] = {
		DiffRemove = {
			provider = "DiffRemove",
			condition = condition.hide_in_width,
			icon = "  ",
			highlight = { colors.red, colors.bg },
		},
	}

	gls.right[4] = {
		FileEncode = {
			provider = "FileEncode",
			condition = condition.hide_in_width,
			separator = " ",
			separator_highlight = { "NONE", colors.bg },
			highlight = { colors.green, colors.bg, "bold" },
		},
	}

	gls.right[5] = {
		FileFormat = {
			provider = "FileFormat",
			condition = condition.hide_in_width,
			separator = " ",
			separator_highlight = { "NONE", colors.bg },
			highlight = { colors.green, colors.bg, "bold" },
		},
	}

	gls.right[6] = {
		GitIcon = {
			provider = function()
				return "  "
			end,
			condition = function()
				return condition.check_git_workspace() and short_hide_condition()
			end,
			separator = " ",
			separator_highlight = { "NONE", colors.bg },
			highlight = { colors.violet, colors.bg, "bold" },
		},
	}

	gls.right[7] = {
		GitBranch = {
			provider = "GitBranch",
			condition = function()
				return condition.check_git_workspace() and short_hide_condition()
			end,
			highlight = { colors.violet, colors.bg, "bold" },
		},
	}

	gls.short_line_left[1] = gls.left[1]
	gls.short_line_left[2] = gls.left[2]
	gls.short_line_left[3] = gls.left[3]
	gls.short_line_left[4] = gls.left[4]
	gls.short_line_left[5] = gls.left[5]
	gls.short_line_right[6] = gls.right[6]
	gls.short_line_right[7] = gls.right[7]
end

vim.cmd([[
  if strlen($term)>0
    " for opacity in terminal
    autocmd ColorScheme * hi StatusLine guibg=NONE ctermbg=NONE
  endif
]])
