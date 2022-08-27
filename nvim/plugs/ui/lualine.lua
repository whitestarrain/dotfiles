vim.cmd([[
  Plug 'nvim-lualine/lualine.nvim'
]])

require("au")["User LoadPluginConfig"] = function()
	local status, lualine = pcall(require, "lualine")
	if not status then
		return
	end

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

	-- Get diff data
	-- support plugins: vim-gitgutter vim-signify coc-git
	local function get_hunks_data()
		-- { added = add_count, modified = modified_count, removed = removed_count }
		local diff_data = { 0, 0, 0 }
		if vim.fn.exists("*GitGutterGetHunkSummary") == 1 then
			for idx, v in pairs(vim.fn.GitGutterGetHunkSummary()) do
				diff_data[idx] = v
			end
			return diff_data
		elseif vim.fn.exists("*sy#repo#get_stats") == 1 then
			diff_data[1] = vim.fn["sy#repo#get_stats"]()[1]
			diff_data[2] = vim.fn["sy#repo#get_stats"]()[2]
			diff_data[3] = vim.fn["sy#repo#get_stats"]()[3]
			return diff_data
		elseif vim.fn.exists("b:gitsigns_status") == 1 then
			local gitsigns_dict = vim.api.nvim_buf_get_var(0, "gitsigns_status")
			diff_data[1] = tonumber(gitsigns_dict:match("+(%d+)")) or 0
			diff_data[2] = tonumber(gitsigns_dict:match("~(%d+)")) or 0
			diff_data[3] = tonumber(gitsigns_dict:match("-(%d+)")) or 0
		end
		return {
			added = diff_data[1],
			modified = diff_data[2],
			removed = diff_data[3],
		}
	end

	local function get_lsp_client()
		local msg = ""
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

	local conditions = {
		buffer_not_empty = function()
			return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
		end,
		hide_in_width = function()
			return vim.fn.winwidth(0) > 110
		end,
		check_git_workspace = function()
			local filepath = vim.fn.expand("%:p:h")
			local gitdir = vim.fn.finddir(".git", filepath .. ";")
			return gitdir and #gitdir > 0 and #gitdir < #filepath
		end,
	}

	local function get_lualine_theme()
		if vim.g.colors_name == "neosolarized" then
			return "solarized_dark"
		end
		return "auto"
	end

	lualine.setup({
		options = {
			icons_enabled = true,
			theme = get_lualine_theme(),
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
			disabled_filetypes = { "tagbar", "Outline" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = {
				{
					"filename",
					file_status = true, -- displays file status (readonly status, modified status)
					path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
					separator = { right = nil },
				},
				{
					"diff",
					colored = true, -- Displays a colored diff status if set to true
					symbols = { added = "  ", modified = " 柳", removed = "  " }, -- Changes the symbols used by the diff.
					source = get_hunks_data,
					separator = { left = nil, right = nil },
					cond = conditions.hide_in_width,
				},
				{
					-- Insert mid section. You can make any number of sections in neovim :)
					-- for lualine it's any number greater then 2
					function()
						return "%="
					end,
					separator = { left = nil, right = nil },
					cond = conditions.hide_in_width,
				},
				{
					get_lsp_client,
					icon = " LSP:",
					cond = function()
						local tbl = { ["dashboard"] = true, [""] = true }
						if tbl[vim.bo.filetype] then
							return false
						end
						return conditions.buffer_not_empty() and conditions.hide_in_width()
					end,
					color = { fg = colors.cyan, gui = "bold" },
				},
			},
			lualine_x = {
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = { error = " ", warn = " ", info = " ", hint = " " },
					cond = conditions.hide_in_width,
				},
				{
					"fileformat",
					symbols = {
						unix = "unix",
						dos = "dos",
						mac = "mac",
					},
					cond = conditions.hide_in_width,
				},
				"encoding",
				{
					"filetype",
					cond = conditions.hide_in_width,
				},
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{
					"filename",
					file_status = true, -- displays file status (readonly status, modified status)
					path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
				},
			},
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		extensions = { "fugitive", "nvim-tree" },
	})
end
