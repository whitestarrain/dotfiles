vim.cmd([[
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'whitestarrain/telescope-file-browser.nvim'
]])

require("au")["User LoadPluginConfig"] = function()
	local status, telescope = pcall(require, "telescope")
	if not status then
		return
	end

	local actions = require("telescope.actions")
	local fb_actions = require("telescope").extensions.file_browser.actions

	local function telescope_buffer_dir()
		return vim.fn.expand("%:p:h")
	end

	telescope.setup({
		defaults = {
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			-- lua regex
			file_ignore_patterns = {
				"%.png",
				"%.jpg",
				"%.jpeg",
				"%.exe",
				"%.pdf",
				"%.doc",
				"%.docx",
				"%.tux",
				"%.cache",
				"%.gif",
				"%.mm",
			},
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			prompt_prefix = "❯ ",
			layout_config = {
				prompt_position = "top",
				vertical = {
					mirror = false,
				},
				preview_cutoff = 120,
			},
			initial_mode = "insert",
			mappings = {
				n = {
					["q"] = actions.close,
					["/"] = function()
						vim.cmd("startinsert")
					end,
				},
			},
		},
		path_display = { "truncate" },
		winblend = 0,
		extensions = {
			file_browser = {
        layout_config = {
          prompt_position = "top",
          vertical = {
            mirror = false,
          },
          preview_cutoff = 120,
          preview_width = 50,
        },
				-- disables netrw and use telescope-file-browser in its place
				hijack_netrw = true,
        hide_parent_dir = true,
				mappings = {
					["i"] = {
						["<C-w>"] = function()
							vim.cmd("normal vbd")
						end,
					},
					["n"] = {
						["A"] = fb_actions.create,
            ["d"] = fb_actions.remove,
            ["D"] = fb_actions.remove,
						["h"] = fb_actions.goto_parent_dir,
						["l"] = actions.select_default,
					},
				},
			},
		},
		preview = {
			timeout = 500,
		},
	})

	require("telescope").load_extension("file_browser")

	vim.keymap.set("n", "fh", function()
		telescope.extensions.file_browser.file_browser({
			path = "%:p:h",
			cwd = telescope_buffer_dir(),
			respect_gitignore = false,
			hidden = true,
			grouped = true,
			initial_mode = "normal",
		})
	end)

	vim.cmd([[
    nnoremap <silent><leader>ff :Telescope find_files<CR>
    let g:which_key_map.f.f = 'find files'

    nnoremap <silent><leader>/ :Telescope buffers<CR>

    nnoremap <silent><leader>fc :Telescope commands<CR>
    let g:which_key_map.f.c = 'find command'

    nnoremap <silent><leader>fa :Telescope<CR>
    let g:which_key_map.f.a = 'all_find_command'

    nnoremap <silent><leader>fg :Telescope live_grep<CR>
    let g:which_key_map.f.g = 'live_grep'

    nnoremap <silent><leader>fg :Telescope live_grep<CR>
    let g:which_key_map.f.g = 'live_grep'
  ]])
end
